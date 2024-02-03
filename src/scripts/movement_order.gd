extends Object
class_name MovementOrder

enum movementTypeEnum {
	TO_POINT,
	LINE,
	CIRCLE,
	RETREAT
}

var speed : int
var destination: Vector2
var target: Vector2
var angle: float = 0
var angleTarget: float
var movementType: movementTypeEnum

func _init(_movementType:movementTypeEnum, _target: Vector2, _speed:float, _angleTarget = 2*PI):
	movementType = _movementType
	target = _target
	speed = _speed
	destination = target
	angleTarget = _angleTarget
