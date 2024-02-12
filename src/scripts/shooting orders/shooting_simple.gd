extends BaseShootingOrder

@export var nbOfWaves:int = 1
@export var nbOfShots:int = 1
@export var angle:float = 0
@export var dt:float = 0
@export var target:Vector2 = Vector2(-1, -1)

func _construct(_bullet_scene : PackedScene, _timeBetweenEachAttack : float, _nbOfWaves : int, _nbOfShots:int, _angle:float, _dt:float, _target:Vector2):
	_base_construct(_bullet_scene, _timeBetweenEachAttack)
	nbOfWaves = _nbOfWaves
	nbOfShots = _nbOfShots
	angle = _angle
	dt = _dt
	target = _target
	return self

#func _ready():
	#super()
	#$Timer

func shoot():
	var direction: Vector2 = target
	for j in nbOfWaves : 
		if j > 0 :
			await get_tree().create_timer(dt, false).timeout
		if target == Vector2(-1,-1):
			direction = (playing_field.playerPosition - get_parent().position)
		for i in nbOfShots :
			var rotation = 0#direction.angle()
			if nbOfShots != 1:
				rotation = PI/180*angle*(float(i)/(nbOfShots - 1) - 0.5)
			spawn_bullet(direction, rotation)


#func shoot_simple(nbOfWaves:int, nbOfShots:int, angle:float, dt:float, speed:float, bulletClass, target:Vector2 = Vector2(0, 0), damage = 0):
	#var playing_field = get_tree().get_first_node_in_group("Field")
	#var direction: Vector2 = target
	#for j in nbOfWaves : 
		#if j > 0 :
			#await get_tree().create_timer(dt, false).timeout
		#if target == Vector2(-1,-1):
			#direction = (playing_field.playerPosition - get_parent().position)
		#for i in nbOfShots :
			#var rotation = 0
			#if nbOfShots != 1:
				#rotation = PI/180*angle*(float(i)/(nbOfShots - 1) - 0.5)
			#var bullet = bulletClass.instantiate()
			#if damage != 0:
				#bullet.damage = damage
			#bullet.position = get_parent().position
			#var manager = preload("res://src/scenes/Movement Orders/movement_manager.tscn").instantiate()
			#var movement_order = get_child(0)
			#manager.rotate = true
			#movement_order.speed = speed
			#movement_order.target = direction.rotated(rotation)
			#bullet.add_child(manager)
			#bullet.get_node("Movement Manager").add_child(movement_order)
			#bullet.rotation = rotation + PI/2
			#playing_field.add_child(bullet)
#func _process(delta):
	#match shootingType:
		#ShootingTypeEnum.SIMPLE: 
			#shoot_simple(nbOfWaves, nbOfShots, angle, dt, speed, bulletClass, target)

#@export var speed:float 
#var bulletClass:Bullet  
#var shootingType: ShootingTypeEnum
#
#func _initiate(_shootingType:ShootingTypeEnum, _nbOfWaves:int, _nbOfShots:int, _angle:float, _dt:float, _speed:float, _bulletClass:Bullet,  _target:Vector2 = Vector2(0, 0), _damage: int = 0):
	#shootingType = _shootingType
	#target = _target
	#speed = _speed
	#dt = _dt
	#bulletClass = _bulletClass
	#angle = angle
	#nbOfWaves = _nbOfWaves
	#nbOfShots = _nbOfShots
	#playing_field = get_tree().get_first_node_in_group("Field")

#enum ShootingTypeEnum {
	#SIMPLE
#}



