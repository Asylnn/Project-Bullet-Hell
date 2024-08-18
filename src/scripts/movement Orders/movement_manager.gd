extends Node
class_name MovementManager

@onready var entity : Entity  = get_parent()
var paused = false
@export var global_speed : float = 100
@export var rotate = true
@export var retreat = true
@onready var current_order : BaseMovementOrder = get_child(0)
	
func _ready():
	if get_child_count() == 0 :
		provide_order()
		current_order = get_child(0)
	for child : BaseMovementOrder in get_children():
		child.start_moving()

func provide_order():
	if retreat :
		var retreat_order = preload("res://src/scenes/Movement Orders/movement_retreat.tscn").instantiate()
		retreat_order.speed = global_speed
		add_child(retreat_order)
	else : 
		var immobile_order = preload("res://src/scenes/Movement Orders/movement_to_point.tscn").instantiate()
		immobile_order.speed = 0
		add_child(immobile_order)

func new_order():
	if get_child_count() == 1 :
		provide_order()
	current_order = get_child(1)

func set_initial_direction(direction: Vector2):
	
	#On a besoin de faire en sorte que cette fonction modifile les propriétés de base de l'entité (sa rotation ...)
	for child in get_children():
		if child is MovementLine: get_child(0).direction = direction


## Sets the speed of 
func set_speed(speed: float):
	for child : BaseMovementOrder in get_children():
		child.speed = speed

func _process(delta):
	#if entity is Bullet :
		#print("order speed", current_order.speed)
	current_order.move(entity, delta)


