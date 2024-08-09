extends BaseMovementOrder
class_name MovementLine

@export var direction : Vector2 = Vector2(0,0)
@export var speed : float = -1

func move(entity: Entity, delta: float):
	_moveAndRotate(entity, direction, speed, delta)
