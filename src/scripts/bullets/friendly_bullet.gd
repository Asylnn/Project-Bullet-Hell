extends Bullet
class_name FriendlyBullet

# Called when the node enters the scene tree for the first time.

func _ready():
	if has_node("Sprite2D") :
		$Sprite2D.modulate.a = 0.5
	super()
