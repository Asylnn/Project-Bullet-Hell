extends BaseMovementOrder

@export var target : Vector2 = Vector2(0,0)
@export var speed : float = -1

func _construct(_template, _target, _speed):
	_base_construct(_template)
	target = _target
	speed = _speed
	return self

func _ready():
	super()
	destination = target

func move(entity: Entity, delta: float):
	var direction = target - entity.position
	_moveAndRotate(entity, direction, speed, delta)
	
	
