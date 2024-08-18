extends BaseMovementOrder

@export var center : Vector2 = Vector2(0,0)
@export var speed : float = -1
@export var angle : float = PI
@export var totalRotation : float = 2*PI
var startingAngle : float

func _ready():
	super()
	startingAngle = angle
	
func calculate_position(angle, r , center):
	return center + r*Vector2(sin(angle), cos(angle))
	

func move(entity: Entity, delta:float):
	
	var axe = center - entity.position
	var r = axe.length()
	var theta = speed*delta/r
	angle += theta
	entity.position = calculate_position(angle, r, center)
	if rotate : 
		entity.rotation = Vector2(cos(angle), -sin(angle)).angle() + PI/2
	if totalRotation <= abs(angle) - startingAngle :
		entity.position = calculate_position(startingAngle + totalRotation, r, center)
		order_reached_destination.emit()
		queue_free()
