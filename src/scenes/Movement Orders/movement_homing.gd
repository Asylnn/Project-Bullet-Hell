extends BaseMovementOrder
class_name MovementHoming

enum targetType {
	ENEMY,
	PLAYER
}

@export var target_type : targetType = targetType.ENEMY
@export var speed : float = 100
@export var mass : float = 10
var firstTimeMoved: bool = false
var target : Enemy

func _construct(_template, _target_type, _speed, _mass):
	_base_construct(_template)
	target_type = _target_type
	speed = _speed
	mass = _mass
	return self
	
func move(entity: Entity, delta: float):
	print("test")
	if not firstTimeMoved or not is_instance_valid(target):
		print("okbuddyosu")
		if target_type == targetType.ENEMY:
			var enemies = get_tree().get_nodes_in_group("Enemy")
			var closest_enemy_distance : float = 100000
			print(enemies)
			for enemy in enemies:
				var axe: Vector2 = enemy.position - entity.position
				print("axe ", axe)
				print("enemy ", enemy)
				var r = axe.length()
				print("r ", r)
				if r <= closest_enemy_distance :
					closest_enemy_distance = r
					target = enemy
	if is_instance_valid(target) :
		firstTimeMoved = true
		var direction_to_target = (target.position - entity.position).normalized()
		var effective_direction =  (Vector2(1,0).rotated(entity.rotation - PI/2)*mass + direction_to_target).normalized()
		print("direction ", direction_to_target, effective_direction)
		_moveAndRotate(entity, effective_direction, speed, delta)
	else :
		_moveAndRotate(entity, Vector2(1,0).rotated(entity.rotation - PI/2).normalized(), speed, delta)
		
