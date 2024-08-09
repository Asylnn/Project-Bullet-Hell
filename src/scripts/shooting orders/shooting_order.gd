extends Node2D
class_name BaseShootingOrder
@export var bullet_scene: PackedScene
@export var time_between_each_attacks : float = 1
@export var damage : float = -1
@export var pooling_id: String
var parent_position : Vector2
var manager : ShootingManager
var is_active = true
var speed : float
var bullet : Bullet

func ask_for_bullet_reserve(): #virtual method
	pass
	


func construct_bullet() -> Bullet:
	var _bullet = bullet_scene.instantiate()
	_bullet.damage = damage
	_bullet.pooling_id = pooling_id
	var movement_order = get_children().filter(func(child): return child is BaseMovementOrder)[0].duplicate()
	_bullet.get_node("Movement Manager").add_child(movement_order)
	return _bullet
	
func _ready():
	if not get_parent() is Pool :
		manager = get_parent()
		speed = get_children().filter(func(child): return child is BaseMovementOrder)[0].speed
		$Timer.wait_time = time_between_each_attacks
		if manager.shooter_identity == manager.ShooterIdentityEnum.SPELLCARD :
			$Timer.stop()	
		ask_for_bullet_reserve()
	
func _process(delta):
	if not get_parent() is Pool :	
		if manager.shooter_identity == manager.ShooterIdentityEnum.SPELLCARD :
			if Input.is_action_pressed("shoot") and manager.armed:
				_check_timer_before_shooting()
		elif manager.shooter_identity == manager.ShooterIdentityEnum.ENEMY :
			_check_timer_before_shooting()

func _check_timer_before_shooting():
	if $Timer.is_stopped() :
		$Timer.start()
		shoot()

func shoot(): #inherited function
		pass

func activate_bullet(direction: Vector2, rotation: float):
	bullet = manager.pool.provide_entity(pooling_id)
	manager.playing_field.add_child(bullet)
	bullet.position = manager._get_spawn_position()
	direction = direction.rotated(rotation)
	bullet.find_child("Movement Manager").set_initial_direction(direction)
	bullet.rotation = direction.angle() + PI/2
	
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
