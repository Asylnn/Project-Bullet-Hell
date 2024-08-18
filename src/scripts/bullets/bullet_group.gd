class_name BulletGroup extends Resource

@export var nb_of_bullets : int = 1
@export var space_between_each_bullet_expression : String = "0"
var space_between_each_bullet : float :
	get:
		expr.parse(space_between_each_bullet_expression)
		return expr.execute([], resource_for_expression)

var expr : Expression = Expression.new()
var resource_for_expression : Node

func _init(_nb_of_bullets : int = 1, _space_between_each_bullet : float = 0):
	nb_of_bullets = _nb_of_bullets
	space_between_each_bullet = _space_between_each_bullet
