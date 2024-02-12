extends BaseMovementOrder

@export var direction : Vector2 = Vector2(0,0)
@export var speed : float = -1

func _construct(_direction, _speed, _template):
	_base_construct(_template)
	direction = _direction
	speed = _speed
	return self

func move(entity: Entity, delta: float):
	_moveAndRotate(entity, direction, speed, delta)
