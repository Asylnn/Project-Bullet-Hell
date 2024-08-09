extends Area2D
class_name Entity

var pooling_id : String = "base"
var is_pooled : bool = true

func ask_for_being_pooled():
	var pool = get_tree().get_first_node_in_group("Pool")
	if pool.has_free_space_for_pooling(pooling_id) :
		position = Vector2(0,0)
		$"Movement Manager".paused = true
		pool.put_to_pool(pooling_id, self)
	else:
		pool.report_unfield(pooling_id)
		queue_free()

func _ready():
	if not self is Bullet:
			$"Movement Manager".paused = false

func _process(delta): #Process Killzone
	var screensize = get_viewport_rect().size
	if global_position.y >= Parameters.killzone + screensize.y or global_position.x >= Parameters.killzone + screensize.x or global_position.x <= -Parameters.killzone or global_position.y <= -Parameters.killzone:
		if self is Bullet:
			ask_for_being_pooled()
		else: 
			queue_free()


#var rotate: bool = true
#var orders: Array[MovementOrder] = []
#
#var retreatOrder = MovementOrder.new(MovementOrder.movementTypeEnum.RETREAT, Vector2(0,0), 200)
#
#func _moveToPoint(order:MovementOrder, delta: float):
	#var direction = order.target - position
	#_moveAndRotate(order, direction, delta)
#
#func _moveLine(order:MovementOrder, delta: float):
	#_moveAndRotate(order, order.target, delta)
#
#func _moveCircleOld(order:MovementOrder, delta:float):
	#var axe = order.target - position
	#var direction = Vector2(axe.y, -axe.x)
	#_moveAndRotate(order, direction, delta)
#
#func _moveCircle(order:MovementOrder, delta:float):
	#var axe = order.target - position
	#var r = axe.length()
	#var theta = order.speed*delta/r
	#order.angle += theta
	#position = order.target + r*Vector2(sin(order.angle), cos(order.angle))
	#if rotate : 
		#rotation = Vector2(cos(order.angle), -sin(order.angle)).angle() + PI/2
	#
#func _retreat(order:MovementOrder, delta):
	#var direction = Vector2(1, -0.5)
	#if(position.x <= 515):
		#direction = Vector2(-1,-0.5)
	#_moveAndRotate(order, direction, delta)
		#
#
#func _movementDetermination(delta:float):
	#var order: MovementOrder
	#if orders.size() == 0 :
		#order = retreatOrder
	#else :
		#order = orders[0]
	#match order.movementType:
		#MovementOrder.movementTypeEnum.TO_POINT:
			#_moveToPoint(order, delta)
		#MovementOrder.movementTypeEnum.LINE:
			#_moveLine(order, delta)
		#MovementOrder.movementTypeEnum.RETREAT:
			#_retreat(order, delta)
		#MovementOrder.movementTypeEnum.CIRCLE:
			#if order.destination != position:
				#order.destination = position
			#_moveCircle(order, delta)
	#
	#if (position - order.destination).length() <= 2 or order.angleTarget <= abs(order.angle) :
		#position = order.destination
		#orders.pop_front()
#
#func _moveAndRotate(order:MovementOrder, direction: Vector2, delta: float):
	#direction = direction.normalized()
	#position += direction*order.speed*delta
	#if rotate : 
		#rotation = direction.angle() + PI/2
#
#func _process(delta):
	#_movementDetermination(delta)
	#var screensize = get_viewport_rect().size
	#if position.y >= Parameters.killzone + screensize.y or position.x >= Parameters.killzone + screensize.x or position.x <= -Parameters.killzone or position.y <= -Parameters.killzone:
		#self.queue_free()
	
