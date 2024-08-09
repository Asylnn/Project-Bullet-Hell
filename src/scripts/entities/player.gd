extends CharacterBody2D
class_name Player
const SPEED = 300.0
const SHIFT_SPEED_MULTIPLIER = 0.5
const SHOOTING_SPEED = 0.1
const INVENTORY_SIZE = 12
var is_flickering = false
signal player_died

func _ready():
	position = Parameters.initialPlayerPos
	
func _process(delta):
	var speedMultiplier = 1
	if Input.is_action_pressed("Shift Move "):
		speedMultiplier *= SHIFT_SPEED_MULTIPLIER
	if Input.is_action_pressed("Move Down"):
		position.y += SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Up"):
		position.y += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Left"):
		position.x += -SPEED*delta*speedMultiplier
	if Input.is_action_pressed("Move Right"):
		position.x += SPEED*delta*speedMultiplier
		
	#if Input.is_action_pressed("shoot") and shootingTimer.time_left == 0:
		#shootingTimer.start()
		#shoot()
	if is_flickering :
		$"Ship Sprite".modulate.a = 0.5
	
		
func _physics_process(delta):
	move_and_slide()

func _on_hitbox_area_area_entered(area):
	if area.is_in_group("Enemy Bullet") and $"Imunity Timer".time_left == 0:
		player_died.emit()
		$"Imunity Timer".start()
		$"Flicker Timer".start()	
		is_flickering = true
		_flicker()
		#
#func shoot():
	#var bulletClass = preload("res://src/scenes/friendly_bullet.tscn")
	#var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	#add_child(shootingPattern)
	#shootingPattern.shoot_simple(get_parent(), 1, 1, 0, 0, 2000,bulletClass, Vector2(0, -1))


func _on_imunity_timer_timeout():
	$"Flicker Timer".stop()
	is_flickering = false
	_flicker()


func _on_flicker_timer_timeout():
	is_flickering = not is_flickering
	_flicker()

func _flicker():
	if is_flickering :
		$"Ship Sprite".modulate.a = 0.5
	else : 
		$"Ship Sprite".modulate.a = 1
