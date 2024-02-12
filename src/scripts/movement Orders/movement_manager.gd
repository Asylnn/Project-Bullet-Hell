extends Node2D

var entity : Entity
@export var global_speed : float = 100
@export var rotate : bool = true

func _ready() : 
	entity = get_parent()
	

func _process(delta):
	if(!get_children()) :
		add_child(preload("res://src/scenes/Movement Orders/movement_retreat.tscn").instantiate())
	get_child(0).move(entity, delta)


