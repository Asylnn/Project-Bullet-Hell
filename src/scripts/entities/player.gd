@icon("res://icon.svg")
class_name Player extends CharacterBody2D
## This class is used for controlling the player controlled ship
## 
## It is only used for controlling the ship and it's various hitboxs.
## The firing logic is handled by [ActiveSpellSlot].



const SPEED : float = 300.0 										## Speed of the player
const SHIFT_SPEED_MULTIPLIER : float = 0.5							## Slowing coefficient of pressing shift to slow down the player
var is_flickering : bool = false							## Is the player ship flickering ? Used in the getting touched animation
@onready var inventory : Inventory = get_tree().get_first_node_in_group("Inventory")

signal recieved_collectible(collectible : Collectible)		## Signal for signaling if the player recieved a collectible to the inventory
signal player_hit											## Signal for signaling if the player was hit, used for removing a life from the UI

func _ready():	position = Parameters.initialPlayerPos
	
func _process(delta):
	var speedMultiplier = 1
	if Input.is_action_pressed("Shift Move "): speedMultiplier *= SHIFT_SPEED_MULTIPLIER
	
	if Input.is_action_pressed("Move Down"): 	position.y += SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Up"): 		position.y += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Left"): 	position.x += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Right"):	position.x += SPEED*delta*speedMultiplier

	if Input.is_action_pressed("Bomb") and not get_tree().get_first_node_in_group("Bomb") and inventory.mana >= 10 :
		var bomb = preload("res://src/scenes/entities/bomb/bomb.tscn").instantiate()
		inventory.add_mana(-10)
		bomb.position.x = position.x
		bomb.position.y = position.y
		get_parent().add_child(bomb)
		 
func _physics_process(delta): move_and_slide()

func _on_hitbox_area_area_entered(area):
	if $"Imunity Timer".time_left == 0:
		$"Imunity Timer".start(); $"Flicker Timer".start()
		player_hit.emit()
		is_flickering = true
		_flicker()

func _on_collect_area_area_entered(area):
	recieved_collectible.emit(area)
	area.queue_free()
	
	
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



