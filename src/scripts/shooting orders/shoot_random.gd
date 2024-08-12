extends BaseShootingOrder

@export var angle : float = 0
@export var nbOfShots : int = 1
@export var angleProbability : Callable
@export var target : Vector2 = Vector2(-1, -1)
@export var target_type : ShootingManager.TargetTypeEnum


func ask_for_bullet_reserve():
	var number_of_bullet_asked = 2000/speed*nbOfShots*(1/time_between_each_attacks)
	manager.get_pooling_order(self, pooling_id, number_of_bullet_asked)
	print("noba", number_of_bullet_asked)
	print("pi", pooling_id)
	
func shoot():
	var direction = manager.get_direction(target, target_type)
	for i in nbOfShots :
		shot = i
		var bullet_angle = randf_range(-angle, angle)
		var rotation = PI/180*bullet_angle
		activate_bullet(direction, rotation)
