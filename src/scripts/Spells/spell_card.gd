extends Control
class_name SpellCard

#func _construct(_iconPath: String, _cooldown : float):
	#cooldown = _cooldown
	#iconPath = _iconPath
	#return self

#func _ready():
	#$Timer.wait_time = cooldown
	
#func _stop_timer():
	#$Timer.stop()

#func fire():
	#$Timer.start()
	##Currently the code is only made for one child, if more childs were to be added, fire should be called independently for each child, moreover the cooldown property will have to be reworked
	#for pattern in get_children():
		#if pattern is Timer:
			#pattern.shoot()
	#var bulletClass = preload("res://src/scenes/friendly_bullet.tscn")
	#var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	#get_tree().get_first_node_in_group("Player").add_child(shootingPattern)
	#shootingPattern.shoot_simple(1, 1, 0, 0, 2000, bulletClass, Vector2(0, -1), projectileDamage)
