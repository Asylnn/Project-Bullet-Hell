class_name Bomb extends Area2D

@export var damage : int = 100

func _on_area_entered(area):
	area.ask_for_being_pooled()
	
func _process(delta):
	$CollisionShape2D.scale.x += 0.01
	$CollisionShape2D.scale.y += 0.01
	$AnimatedSprite2D.scale.x += 0.01
	$AnimatedSprite2D.scale.y += 0.01


func _on_timer_timeout():
	queue_free()
