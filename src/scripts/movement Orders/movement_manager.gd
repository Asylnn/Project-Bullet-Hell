extends Node
class_name MovementManager

@onready var entity : Entity  = get_parent()
var paused = false
@export var global_speed : float = 100
@export var rotate = true
@export var retreat = true

func set_initial_direction(direction: Vector2):
	#On a besoin de faire en sorte que cette fonction modifile les propriétés de base de l'entité (sa rotation ...)
	if get_child(0) is MovementLine: get_child(0).direction = direction
		
	

func _process(delta):
	if(not get_children()) : #quite ressource heavy
		if retreat :
			add_child(preload("res://src/scenes/Movement Orders/movement_retreat.tscn").instantiate())
		else : 
			var immobile_order = preload("res://src/scenes/Movement Orders/movement_to_point.tscn").instantiate()
			immobile_order.speed = 0
			add_child(immobile_order)
	get_child(0).move(entity, delta)
	pass


