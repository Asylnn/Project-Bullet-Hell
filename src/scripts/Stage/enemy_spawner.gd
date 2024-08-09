extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random(min, max):
	var delta = max - min
	return min + randf()*delta 

func _on_timer_timeout():
	pass
	var enemyClass = preload("res://src/scenes/entities/phantum.tscn")
	if random(0, 4) >= 3 :
		var enemy3 = enemyClass.instantiate()
		var enemy2 = enemyClass.instantiate()
		enemy3.position = Vector2(random(100,900), 50)
		enemy2.position = Vector2(random(100,900), 50)
		get_parent().add_child(enemy2)
		get_parent().add_child(enemy3)
		
	var enemy = enemyClass.instantiate()
	enemy.position = Vector2(random(100,900), 50)
	get_parent().add_child(enemy)
