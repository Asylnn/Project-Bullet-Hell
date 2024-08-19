extends Node
class_name ShootingManager

## The Identity of the parent (it can be an [Entity] or a [SpellCard]
@export var shooter_identity : ShooterIdentityEnum
## Time to wait before shooting for the first time. Shouldn't be used with [SpellCard]
@export var shooting_timer : float = 0
## Timer used in conjunction with [param shooting_timer]
@onready var timer = get_tree().create_timer(shooting_timer)
## The [PlayingField]
@onready var playing_field : Node2D = get_tree().get_first_node_in_group("Field")
## The [Pool]
@onready var pool : Pool = get_tree().get_first_node_in_group("Pool")
## Keeps track of all requested pooling for bullets, so when the ShootingManager disapear it can ask to unpool everything
var requested_pooling_amount : Dictionary = {}
## This bool decide if the orders are allowed to shoot (used currently when there is a delay before shooting (see [param shooting_timer]))
var armed : bool = false

## I don't know if this should be used
enum TargetTypeEnum {
	POINT,
	PLAYER
}

## An Enumeration of all the possible identity the parent of this node can have
enum ShooterIdentityEnum {
	INACTIVE_SPELLCARD,
	SPELLCARD,
	ENEMY
}

func _ready():
	var parent = get_parent()
	if parent is SpellCard: 
		var inventory_slot : InventorySlot = parent.get_parent()
		if inventory_slot is ActiveSpellSlot : 		shooter_identity = ShooterIdentityEnum.SPELLCARD
		else : 										shooter_identity = ShooterIdentityEnum.INACTIVE_SPELLCARD
	if parent is Enemy or parent is EnemyBullet:
		shooter_identity = ShooterIdentityEnum.ENEMY
	await get_tree().create_timer(shooting_timer).timeout
	armed = true

func remove_pooling_order():
	for id in requested_pooling_amount.keys():
		pool.free_pool(id, requested_pooling_amount[id])

func get_pooling_order(shooter: BaseShootingOrder, id : String, number: int):
	if requested_pooling_amount.has(id):
		requested_pooling_amount[id] += number
	else :
		requested_pooling_amount[id] = number
	if Pool.has_entity(id):
		Pool.request_entity_pooling(id, number)
		shooter.erase_children()
	else: 
		Pool.request_new_entity_pooling(shooter.provide_constructor(), id, number)
	
func get_direction(target, target_type) -> Vector2:
	var direction : Vector2
	if target_type == TargetTypeEnum.POINT :
		direction = target - get_parent().position
	elif target_type == TargetTypeEnum.PLAYER :
		direction = (playing_field.playerPosition - get_parent().position)
	return direction

func _get_spawn_position(): 
	if shooter_identity == ShooterIdentityEnum.SPELLCARD:
		return playing_field.playerPosition
	elif shooter_identity ==  ShooterIdentityEnum.ENEMY:
		return get_parent().position

	


