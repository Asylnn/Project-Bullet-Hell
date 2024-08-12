extends Node


@onready var phantum_scene = preload("res://src/scenes/entities/phantum.tscn")
@onready var crystal_scene = preload("res://src/scenes/entities/crystal.tscn")
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random(min, max):
	var delta = max - min
	return min + randf()*delta 

func _spawn_phantum():
	var enemy = phantum_scene.instantiate()
	enemy.position = Vector2(random(100,900), 50)
	get_parent().add_child(enemy)
	
	
func _spawn_crystal():
	var enemy = crystal_scene.instantiate()
	enemy.position = Vector2(550, -20)
	get_parent().add_child(enemy)



func _on_timer_timeout():
	pass
	if count == 8:
		$Timer.stop()
		_spawn_crystal()
	else : 
		_spawn_phantum()
		if random(0, 4) >= 3 :
			_spawn_phantum()
			_spawn_phantum()
		count += 1
	
	
