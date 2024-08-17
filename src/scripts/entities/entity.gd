class_name Entity extends Area2D

var pooling_id : String = "base"
var is_pooled : bool = true

func ask_for_being_pooled():
	if get_tree(): #????????????????????????
		var pool = get_tree().get_first_node_in_group("Pool")
		if pool.has_free_space_for_pooling(pooling_id) :
			get_parent().remove_child(self)
			pool.put_to_pool(pooling_id, self)
		else:
			pool.report_unfield(pooling_id)
			queue_free()

func _ready():
	#if not self is Bullet:
			#$"Movement Manager".paused = false
	var anim = find_child("AnimatedSprite2D")
	if anim: 
		$"AnimatedSprite2D".play("default")

func _process(delta): #Process Killzone
	var screensize = get_viewport_rect().size
	if global_position.y >= Parameters.killzone + screensize.y or global_position.x >= Parameters.killzone + screensize.x or global_position.x <= -Parameters.killzone or global_position.y <= -Parameters.killzone:
		if self is Bullet:
			ask_for_being_pooled()
		else: 
			queue_free()

func _on_area_entered(area):
	pass # Replace with function body.
