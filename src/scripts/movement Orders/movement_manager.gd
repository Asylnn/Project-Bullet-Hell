extends Node
class_name MovementManager

@onready var entity : Entity  = get_parent()
var paused = false
@export var global_speed : float = 100
@export var rotate = true
@export var retreat = true

func _ready():
	for child : BaseMovementOrder in get_children():
		child.start_moving()

func set_initial_direction(direction: Vector2):
	
	#On a besoin de faire en sorte que cette fonction modifile les propriétés de base de l'entité (sa rotation ...)
	for child in get_children():
		if child is MovementLine: get_child(0).direction = direction

func set_speed(speed: float):
	for child : BaseMovementOrder in get_children():
		child.speed = speed

func _process(delta):
	if(get_child_count() == 0) : #quite ressource heavy ? (was get_children() before)
		if retreat :
			var retreat_order = preload("res://src/scenes/Movement Orders/movement_retreat.tscn").instantiate()
			retreat_order.speed = global_speed
			add_child(retreat_order)
		else : 
			var immobile_order = preload("res://src/scenes/Movement Orders/movement_to_point.tscn").instantiate()
			immobile_order.speed = 0
			add_child(immobile_order)
	get_child(0).move(entity, delta)
	pass


