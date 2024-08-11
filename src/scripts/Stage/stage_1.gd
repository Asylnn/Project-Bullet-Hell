extends Node2D

@export var shootingSpeed = 10

var totalScore = 0
var lives = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in lives :
		$"Lives".add_item("", load("res://Sprites/heart.png"), false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _input(event):
	if event.is_action_pressed("return to main menu "):
		get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
	if event.is_action_pressed("pause"):
		$"Pause Menu".visible = !$"Pause Menu".visible
		$"Pause Menu".get_node("Background").modulate.a = 0.5
		get_tree().paused = !get_tree().paused
	if event.is_action_pressed("Open Inventory") :
		$"Inventory".visible = !$"Inventory".visible
	if event.is_action_pressed("Show FPS") :
		$"FPS Counter".visible = !$"FPS Counter".visible 
		$"Node Count".visible = !$"Node Count".visible 
		$"Entity Count".visible = !$"Entity Count".visible 
		$"Changelog".visible = !$"Changelog".visible 

func _on_enemy_died(score):
	totalScore += score
	$"LineEdit".text = str(totalScore)


func _on_player_player_died():
	lives -= 1
	if(lives <= -1) :
		$"Death Menu".visible = true
		get_tree().paused = true
	else :
		$"Lives".remove_item(0)
	


