class_name BulletConstructor extends Node

var pooling_id : String
var bullet_scene : PackedScene
var shooting_manager : ShootingManager
var movement_orders : Array[BaseMovementOrder]

#func _ready():
	#for movement_order in movement_orders :
		#movement_order.process_mode = Node.PROCESS_MODE_INHERIT

func construct_bullet() -> Bullet:
	var bullet : Bullet = bullet_scene.instantiate()
	var bullet_movement_manager : MovementManager = bullet.get_node("Movement Manager")
	bullet.pooling_id = pooling_id
	for order in movement_orders :
		bullet_movement_manager.add_child(order.duplicate())
	
	if shooting_manager :
		var bullet_shooting_manager : ShootingManager = shooting_manager.duplicate()
		bullet_shooting_manager.process_mode = Node.PROCESS_MODE_INHERIT
		bullet.add_child(bullet_shooting_manager)
	return bullet
