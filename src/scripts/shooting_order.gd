extends Object
class_name ShootingOrder

enum ShootingTypeEnum {
	SIMPLE
}

var nbOfWaves:int 
var nbOfShots:int 
var angle:float 
var dt:float 
var speed:float 
var bulletClass:Bullet  
var target:Vector2 = Vector2(0, 0)
var shootingType: ShootingTypeEnum

func _init(_shootingType:ShootingTypeEnum, _nbOfWaves:int, _nbOfShots:int, _angle:float, _dt:float, _speed:float, _bulletClass:Bullet,  _target:Vector2 = Vector2(0, 0)):
	shootingType = _shootingType
	target = _target
	speed = _speed
	dt = _dt
	bulletClass = _bulletClass
	angle = angle
	nbOfWaves = _nbOfWaves
	nbOfShots = _nbOfShots
