extends Node2D
class_name BaseMovementOrder

var rotate : bool
@export var template : bool = true
var destination : Vector2 = Vector2(-1000, -1000)

func _base_construct(_template):
	template = _template

func _ready():
	if not template or self.name == "Movement Retreat" :
		var movement_manager = get_parent()
		rotate = movement_manager.rotate
		if "speed" in self && self.speed == -1: 
			self.speed = movement_manager.global_speed
			
func armed():
	var movement_manager = get_parent()
	rotate = movement_manager.rotate
	
func _moveAndRotate(entity : Entity, direction: Vector2, speed: float, delta: float):
	direction = direction.normalized()
	entity.position += direction*speed*delta
	if rotate : 
		if "damage" in entity:
			pass
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
