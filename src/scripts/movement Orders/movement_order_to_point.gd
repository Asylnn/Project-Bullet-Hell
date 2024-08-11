extends BaseMovementOrder

@export var target : Vector2 = Vector2(0,0)
@export var speed : float = -1

func _ready():
	super()

func move(entity: Entity, delta: float):
	var direction = target - entity.position
	_moveAndRotate(entity, direction, speed, delta)
	
	
