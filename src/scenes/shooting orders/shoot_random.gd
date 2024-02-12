extends BaseShootingOrder

@export var angle : float = 0
@export var nbOfShots : int = 1
@export var angleProbability : Callable
@export var target : Vector2 = Vector2(-1, -1)

func _construct(_bullet_scene: PackedScene, _timeBetweenEachAttack:float, _angle: float, _nbOfShots: int, _target :Vector2, _angleProbability: Callable = func():):
	_base_construct(_bullet_scene, _timeBetweenEachAttack)
	angle = _angle
	nbOfShots = _nbOfShots
	angleProbability = _angleProbability
	target = _target
	return self

func shoot():
	var direction = get_direction(target)
	for i in nbOfShots :
		var bullet_angle = randf_range(-angle, angle)
		var rotation = PI/180*bullet_angle
		spawn_bullet(direction, rotation)
