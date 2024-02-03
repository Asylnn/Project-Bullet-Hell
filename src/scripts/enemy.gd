extends Entity
class_name Enemy

signal enemy_died(score)

@export var shootingSpeed = 2
@export var speed = 100
@export var health = 40
@export var score = 100

# Called when the node enters the scene tree for the first time.

func _ready():
	var ord1 = MovementOrder.new(MovementOrder.movementTypeEnum.TO_POINT, Vector2(514, 400), speed)
	var ord2 = MovementOrder.new(MovementOrder.movementTypeEnum.CIRCLE, Vector2(515, 300), speed*5)
	rotate = false
	orders = [ord1, ord2]
	var ShootTimer = $Shoot
	ShootTimer.wait_time = shootingSpeed
	ShootTimer.start()

func _enter_tree():
	var levelscene = get_tree().current_scene
	enemy_died.connect(levelscene._on_enemy_died)

func _shoot():
	var bulletClass = preload("res://src/scenes/enemy_bullet.tscn")
	var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	add_child(shootingPattern)
	shootingPattern.shoot_simple(2, 4, 30, 0.5, 500, bulletClass)

func _on_shoot_timeout():
	_shoot()
	
func _on_area_entered(area):
	if area.is_in_group("Friendly Bullet"):
		health -= area.damage
		area.queue_free()
		if health <= 0:
			enemy_died.emit(score)
			self.queue_free()
		