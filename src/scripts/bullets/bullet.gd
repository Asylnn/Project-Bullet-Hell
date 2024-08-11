extends Entity
class_name Bullet

@export var type : BulletType
@export var damage : float #Is never set in editor but in shooting pattern

func _on_master_death(score): ask_for_being_pooled()
	

enum BulletType {
	NEUTRAL, #unused
	FRIENDLY,
	ENEMY
}
	
#func _ready():
	#rotation = direction.angle() + PI/2
	#super()



#func _process(delta):
	#super(delta)
