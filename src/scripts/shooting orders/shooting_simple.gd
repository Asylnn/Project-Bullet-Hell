extends BaseShootingOrder

@export var nbOfWaves:int = 1
@export var nbOfShots:int = 1
@export var angle:float = 0
@export var dt:float = 0
@export var target_type : ShootingManager.TargetTypeEnum
@export var target:Vector2 = Vector2(0, 0)

func ask_for_bullet_reserve():
	var number_of_bullet_asked = 1500/speed*nbOfShots*nbOfWaves*(1/time_between_each_attacks)
	manager.get_pooling_order(self, pooling_id, number_of_bullet_asked)

func shoot():
	for j in nbOfWaves : 
		if j > 0 :
			await get_tree().create_timer(dt, false).timeout
		for i in nbOfShots :
			var direction = manager.get_direction(target, target_type)
			var rotation = 0#direction.angle()
			if nbOfShots != 1:
				rotation = PI/180*angle*(float(i)/(nbOfShots - 1) - 0.5)
			activate_bullet(direction, rotation)
