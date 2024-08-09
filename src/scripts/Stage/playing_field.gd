extends Node2D
var playerPosition

func _process(delta):
	playerPosition = $"Player".global_position
	$"Trail".position.y += delta*10
