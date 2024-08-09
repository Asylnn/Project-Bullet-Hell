extends Node2D
class_name MovementManager

var entity : Entity
var paused = false
@export var global_speed : float = 100
@export var rotate = true

func set_initial_direction(direction: Vector2):
	#On a besoin de faire en sorte que cette fonction modifile les propriétés de base de l'entité (sa rotation ...)
	if get_child(0) is MovementLine:
		get_child(0).direction = direction

func _ready() : 
	entity = get_parent()
	

func _process(delta):
	if(not get_children()) : #quite ressource heavy
		add_child(preload("res://src/scenes/Movement Orders/movement_retreat.tscn").instantiate())
	get_child(0).move(entity, delta)
	pass


