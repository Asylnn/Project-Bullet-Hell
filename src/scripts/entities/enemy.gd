class_name Enemy extends Entity

signal enemy_died(score)

#@export var shootingSpeed = 2
#@export var speed = 100
@export var health = 40
@export var score = 100
#@export var expression : Expression
@export var mana_dropped = 0 ## Amount of mana flamed spawned for the player to collect
## Is this enemy a boss ? If true, the boss bar will be showned
@export var is_boss = false

func _ready():
	var ui = get_tree().get_first_node_in_group("UI")
	enemy_died.connect(ui._on_enemy_died)
	if is_boss :
		var boss_bar = get_tree().get_first_node_in_group("Boss Bar")
		boss_bar.boss_spawned(health)
		enemy_died.connect(boss_bar.boss_died)
	super()
	
func _on_area_entered(area):
	health -= area.damage
	if area is FriendlyBullet :
		area.queue_free()
	if is_boss :
		get_tree().get_first_node_in_group("Boss Bar").update_bar(health)
	if health <= 0:
		health = NAN
		enemy_died.emit(score)
		var mana_flame = preload("res://src/scenes/entities/collectibles/mana_flame.tscn")
		var playing_field = get_tree().get_first_node_in_group("Field")
		for i in mana_dropped :
			var mana_flame_scene = mana_flame.instantiate()
			var random_vect = Vector2(Utils.random(-50,50), Utils.random(-50,50))
			if is_boss : random_vect *= 2
			mana_flame_scene.position = position + random_vect
			playing_field.add_child(mana_flame_scene)
		self.queue_free()
