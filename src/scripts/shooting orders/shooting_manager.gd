extends Node
class_name ShootingManager

@export var shooter_identity : ShooterIdentityEnum

## Time to wait before shooting for the first time. Does nothing if it's a spellcard
@export var shooting_timer : float = 0
@onready var timer = get_tree().create_timer(shooting_timer)
@onready var playing_field : Node2D = get_tree().get_first_node_in_group("Field")
@onready var pool : Pool = get_tree().get_first_node_in_group("Pool")
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

func get_pooling_order(shooter: BaseShootingOrder, id : String, number: int):
	if requested_pooling_amount.has(id):
		requested_pooling_amount[id] += number
	else :
		requested_pooling_amount[id] = number
	var pool2 = get_tree().get_first_node_in_group("Pool")
	#?????????????????????????????????????????????????
	if pool2.has_entity(id):
		pool2.request_entity_pooling(id, number)
	else: 
		pool2.request_new_entity_pooling(shooter.provide_constructor(), id, number)
	
func get_direction(target, target_type) -> Vector2:
	var direction : Vector2
	if target_type == TargetTypeEnum.POINT :
		direction = target
		print(direction)		
	elif target_type == TargetTypeEnum.PLAYER :
		direction = (playing_field.playerPosition - get_parent().position)
	return direction

func _get_spawn_position(): 
	if shooter_identity == ShooterIdentityEnum.SPELLCARD:
		return playing_field.playerPosition
	elif shooter_identity ==  ShooterIdentityEnum.ENEMY:
		return get_parent().position

func _ready():
	#print("pool bfr", pool)
	if shooter_identity == ShooterIdentityEnum.ENEMY :
		print("uwu")
		await get_tree().create_timer(shooting_timer).timeout
		print("uwu2")
		
		rearm()


