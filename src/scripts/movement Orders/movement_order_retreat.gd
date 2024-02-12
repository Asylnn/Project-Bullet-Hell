extends BaseMovementOrder

@export var speed : float = -1

func move(entity: Entity, delta : float):
	var direction = Vector2(1, -0.5)
	if(entity.position.x <= 515):
		direction = Vector2(-1,-0.5)
	_moveAndRotate(entity, direction, speed, delta)
