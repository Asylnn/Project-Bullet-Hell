extends BaseShootingOrder

@export var nbOfWaves:int = 1
@export var nbOfShots:int = 1
@export var angle_expression :String = "0"
var angle : float = 0 :
	get:
		expr.parse(angle_expression)
		return expr.execute([], self)

@export var dt:float = 0
@export var target_type : ShootingManager.TargetTypeEnum
@export var target:Vector2 = Vector2(0, 0)

func ask_for_bullet_reserve():
	var number_of_bullet_asked = 1500/speed*nbOfShots*nbOfWaves*(1/time_between_each_attacks)
	manager.get_pooling_order(self, pooling_id, number_of_bullet_asked)
	print("noba", number_of_bullet_asked)
	print("pi", pooling_id)

func shoot():
	salvo += 1
	for j in nbOfWaves : 
		wave = j + 1 
		if j > 0 :
			await get_tree().create_timer(dt, false).timeout
		for i in nbOfShots :
			shot = i + 1
			var direction = manager.get_direction(target, target_type)
			var rotation = 0#direction.angle()
			if nbOfShots != 1:
				rotation = PI/180*(angle*(float(i)/(nbOfShots - 1) - 0.5) + angle_shift)
			activate_bullet(direction, rotation)
