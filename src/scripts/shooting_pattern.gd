extends Node2D

enum ShootingTypeEnum {
	SIMPLE
}

var playing_field:Node2D 
var nbOfWaves:int 
var nbOfShots:int 
var angle:float 
var dt:float 
var speed:float 
var bulletClass:Bullet  
var target:Vector2 = Vector2(0, 0)
var shootingType: ShootingTypeEnum

func _initiate(_shootingType:ShootingTypeEnum, _nbOfWaves:int, _nbOfShots:int, _angle:float, _dt:float, _speed:float, _bulletClass:Bullet,  _target:Vector2 = Vector2(0, 0), _damage: int = 0):
	shootingType = _shootingType
	target = _target
	speed = _speed
	dt = _dt
	bulletClass = _bulletClass
	angle = angle
	nbOfWaves = _nbOfWaves
	nbOfShots = _nbOfShots
	playing_field = get_tree().get_first_node_in_group("Field")


func shoot_simple(nbOfWaves:int, nbOfShots:int, angle:float, dt:float, speed:float, bulletClass, target:Vector2 = Vector2(0, 0), damage = 0):
	var playing_field = get_tree().get_first_node_in_group("Field")
	var direction: Vector2 = target
	for j in nbOfWaves : 
		if j > 0 :
			await playing_field.get_tree().create_timer(dt, false).timeout
		if target == Vector2(0,0):
			direction = (playing_field.playerPosition - get_parent().position)
		for i in nbOfShots :
			var rotation = 0
			if nbOfShots != 1:
				rotation = PI/180*angle*(float(i)/(nbOfShots - 1) - 0.5)
			var bullet = bulletClass.instantiate()
			if damage != 0:
				bullet.damage = damage
			bullet.position = get_parent().position
			var moveOrd = MovementOrder.new(MovementOrder.movementTypeEnum.LINE, direction.rotated(rotation), speed)
			bullet.rotation = rotation + PI/2
			bullet.orders.push_front(moveOrd)
			playing_field.add_child(bullet)

func _process(delta):
	match shootingType:
		ShootingTypeEnum.SIMPLE: 
			shoot_simple(nbOfWaves, nbOfShots, angle, dt, speed, bulletClass, target)


