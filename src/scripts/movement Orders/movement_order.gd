extends Node2D
class_name BaseMovementOrder

@export var rotate : bool
@export var destination : Vector2 = Vector2(-1000, -1000)
var manager : MovementManager

func _ready():
	if self.name == "Movement Retreat" :
		var manager = get_parent()
		rotate = manager.rotate
		if "speed" in self && self.speed == -1: 
			self.speed = manager.global_speed
			
#func armed():
	#var movement_manager = get_parent()
	#rotate = movement_manager.rotate
	
func _moveAndRotate(entity : Entity, direction: Vector2, speed: float, delta: float):
	#if entity is EnemyBullet:
	#	print(direction)
	direction = direction.normalized()
	
	entity.position += direction*speed*delta
	if rotate : 
		entity.rotation = direction.angle() + PI/2
	
	if (entity.position - destination).length() <= 2:
		entity.position = destination
		queue_free()




#enum movementTypeEnum {
	#TO_POINT,
	#LINE,
	#CIRCLE,
	#RETREAT
#}

#var speed : int
#var destination: Vector2
#var target: Vector2
#var angle: float = 0
#var angleTarget: float
#var movementType: movementTypeEnum

#func _init(_movementType:movementTypeEnum, _target: Vector2, _speed:float, _angleTarget = 2*PI):
	#movementType = _movementType
	#target = _target
	#speed = _speed
	#destination = target
	#angleTarget = _angleTarget
