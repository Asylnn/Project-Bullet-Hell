extends Node2D
class_name BaseShootingOrder
@export var bullet_scene: PackedScene
@export var timeBetweenEachAttacks : float = 1
@export var damage : float = -1
var playing_field : Node2D

func _base_construct(_bullet_scene : PackedScene, _timeBetweenEachAttacks : float):
	bullet_scene = _bullet_scene
	timeBetweenEachAttacks = _timeBetweenEachAttacks

func _ready():
	playing_field = get_tree().get_first_node_in_group("Field")
	# We want the pattern to only fire when pressing the button when the damage is different to -1, it's to say it's a player's projectile
	if damage == -1 : 
		$Timer.wait_time = timeBetweenEachAttacks
		$Timer.start()
	
func shoot():
	pass

func spawn_bullet(direction: Vector2, rotation: float):
	print("test12")
	direction = direction.rotated(rotation)
	var bullet = bullet_scene.instantiate()
	if damage != -1:
		bullet.damage = damage
		bullet.position = playing_field.playerPosition
	else :
		bullet.position = get_parent().position
	var manager = preload("res://src/scenes/Movement Orders/movement_manager.tscn").instantiate()
	var movement_order = get_children().filter(func(child): return not child is Timer)[0].duplicate()
	manager.rotate = true
	movement_order.direction = direction
	bullet.add_child(manager)
	bullet.get_node("Movement Manager").add_child(movement_order)
	bullet.rotation = direction.angle() + PI/2
	playing_field.add_child(bullet)
	
func _on_shoot_timeout():
	shoot()
	
#enum ShootingTypeEnum {
	#SIMPLEssss　　sddsssSssssssss
#}
#
#var nbOfWaves:int 
#var nbOfShots:int 
#var angle:float 
#var dt:float 
#var speed:float 
#var bulletClass:Bullet  
#var target:Vector2 = Vector2(0, 0)
#var shootingType: ShootingTypeEnum
#
#func _init(_shootingType:ShootingTypeEnum, _nbOfWaves:int, _nbOfShots:int, _angle:float, _dt:float, _speed:float, _bulletClass:Bullet,  _target:Vector2 = Vector2(0, 0)):
	#shootingType = _shootingType
	#target = _target
	#speed = _speed
	#dt = _dt
	#bulletClass = _bulletClass
	#angle = angle
	#nbOfWaves = _nbOfWaves
	#nbOfShots = _nbOfShots
