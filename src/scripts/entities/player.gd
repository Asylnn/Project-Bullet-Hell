@icon("res://icon.svg")
class_name Player extends CharacterBody2D
## This class is used for controlling the player controlled ship
## 
## It is only used for controlling the ship and it's boundary hitbox.
## The firing logic is handled by [ActiveSpellSlot]. [Bullet] [CharacterBody2D].



const SPEED = 300.0 						## Speed of the player
const SHIFT_SPEED_MULTIPLIER = 0.5			## Slowing coefficient of pressing shift to slow down the player
var is_flickering : bool = false			## Is the player ship flickering ? Used in the getting touched animation

signal player_died							## Signal for signaling if the player was touch (not dead misnamed signal), used for showing the death screen

func _ready():	position = Parameters.initialPlayerPos
	
func _process(delta):
	var speedMultiplier = 1
	if Input.is_action_pressed("Shift Move "): speedMultiplier *= SHIFT_SPEED_MULTIPLIER
	
	if Input.is_action_pressed("Move Down"): 	position.y += SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Up"): 		position.y += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Left"): 	position.x += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Right"):	position.x += SPEED*delta*speedMultiplier

func _physics_process(delta): move_and_slide()

func _on_hitbox_area_area_entered(area):
	if $"Imunity Timer".time_left == 0:
		$"Imunity Timer".start(); $"Flicker Timer".start()
		player_died.emit()
		is_flickering = true
		_flicker()

func _on_imunity_timer_timeout():
	$"Flicker Timer".stop()
	is_flickering = false
	_flicker()


func _on_flicker_timer_timeout():
	is_flickering = not is_flickering
	_flicker()

## This function modulate the alpha channel depending of the value of [param is_flickering]
func _flicker() -> void:
	if is_flickering :	$"Ship Sprite".modulate.a = 0.5
	else : 				$"Ship Sprite".modulate.a = 1
