extends Node2D
class_name ShootingManager

@export var shooter_identity : ShooterIdentityEnum
var playing_field : Node2D
var pool : Pool
var requested_pooling_amount = {}
var armed : bool = false

enum TargetTypeEnum {
	POINT,
	PLAYER
}

enum ShooterIdentityEnum {
	SPELLCARD,
	ENEMY
}

func rearm():
	armed = true
	
func disarm():
	armed = false

func _exit_tree():
	print('what')
	#remove_pooling_order()

func _process(delta):
	if shooter_identity == ShooterIdentityEnum.SPELLCARD :
		if get_parent().get_parent() is ActiveSpellSlot:
			if not armed :
				rearm()
		else :
			if armed :
				disarm()

func remove_pooling_order():
	for id in requested_pooling_amount.keys():
		pool.free_pool(id, requested_pooling_amount[id])

func get_pooling_order(shooting_order: BaseShootingOrder, id : String, number: int):
	print("bbbbbbbbbbbbbbbb")
	if requested_pooling_amount.has(id):
		print("cccccccccccccccccc")	
		requested_pooling_amount[id] += number
	else :
		print("dddddddddddddddd")		
		requested_pooling_amount[id] = number
	var pool2 = get_tree().get_first_node_in_group("Pool")
	#?????????????????????????????????????????????????
	print(requested_pooling_amount)
	pool2.request_entity_pooling(shooting_order.duplicate(), id, number)
	
	
func get_direction(target, target_type) -> Vector2:
	var direction
	if target_type == TargetTypeEnum.POINT :
		direction = target
	elif target_type == TargetTypeEnum.PLAYER :
		direction = (playing_field.playerPosition - get_parent().position)
	return direction

func _get_spawn_position(): 
	if shooter_identity == ShooterIdentityEnum.SPELLCARD:
		return playing_field.playerPosition
	elif shooter_identity ==  ShooterIdentityEnum.ENEMY:
		return get_parent().position

func _ready():
	playing_field = get_tree().get_first_node_in_group("Field")
	pool = get_tree().get_first_node_in_group("Pool")
	#print("pool bfr", pool)
	if shooter_identity == ShooterIdentityEnum.ENEMY :
		rearm()


