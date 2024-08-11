extends Entity
class_name Enemy

signal enemy_died(score)

#@export var shootingSpeed = 2
#@export var speed = 100
@export var health = 40
@export var score = 100
## Is this enemy a boss ? If true, the boss bar will be showned
@export var is_boss = false
#@export var movementOrders : Array[MovementOrder] = []
#func _ready():
	#var ShootTimer = $Shoot
	#ShootTimer.wait_time = shootingSpeed
	#ShootTimer.start()

func _ready():
	var anim = find_child("AnimatedSprite2D")
	if anim: 
		$"AnimatedSprite2D".play("default")

func _enter_tree():
	var levelscene = get_tree().current_scene
	enemy_died.connect(levelscene._on_enemy_died)
	if is_boss :
		var boss_bar = get_tree().get_first_node_in_group("Boss Bar")
		boss_bar.boss_spawned(health)
		enemy_died.connect(boss_bar.boss_died)
#func _shoot():
	#var bulletClass = preload("res://src/scenes/enemy_bullet.tscn")
	#var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	#add_child(shootingPattern)
	#shootingPattern.shoot_simple(2, 4, 30, 0.5, 500, bulletClass)
#
#func _on_shoot_timeout():
	#_shoot()
	
func _on_area_entered(area):
	health -= area.damage
	area.queue_free()
	get_tree().get_first_node_in_group("Boss Bar").update_bar(health)
	if health <= 0:
		enemy_died.emit(score)
		self.queue_free()
