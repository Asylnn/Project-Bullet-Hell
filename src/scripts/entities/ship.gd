extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("Move Down"):
		velocity.y = SPEED
	if Input.is_action_pressed("Move Up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("Move Left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("Move Right"):
		velocity.x = SPEED
	move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("Enemy Bullet"):
		print("AYAYA")
