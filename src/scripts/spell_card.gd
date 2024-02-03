extends Control
class_name SpellCard

var texture : String
var projectileDamage: int
var projectileClass: FriendlyBullet
var cooldown: float

func _init(_texture: String, _projectileClass : FriendlyBullet, _name : String, _projectileDamage: int, _cooldown : float):
	projectileDamage = _projectileDamage
	projectileClass = _projectileClass
	cooldown = _cooldown
	texture = _texture
	
func fire(tree : SceneTree):
	var bulletClass = preload("res://src/scenes/friendly_bullet.tscn")
	var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	tree.get_first_node_in_group("Player").add_child(shootingPattern)
	shootingPattern.shoot_simple(1, 1, 0, 0, 2000, bulletClass, Vector2(0, -1), projectileDamage)
