class_name BulletConstructor extends Node

var pooling_id : String
var bullet_scene : PackedScene

func construct_bullet() -> Bullet:
	var bullet : Bullet = bullet_scene.instantiate()
	#var movement_order = get_children().filter(func(child): return child is BaseMovementOrder)[0].duplicate()
	var movement_order : BaseMovementOrder = get_child(0).duplicate()
	bullet.pooling_id = pooling_id
	bullet.get_node("Movement Manager").add_child(movement_order)
	if $"Shooting Manager" :
		var manager : ShootingManager = $"Shooting Manager".duplicate()
		manager.process_mode = Node.PROCESS_MODE_INHERIT
		bullet.add_child(manager)
	return bullet
