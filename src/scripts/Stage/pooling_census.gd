class_name PoolCensus extends Resource

var requested_amount: int
var number_of_entities_fielded: int = 0
var constructor : BulletConstructor
var stocked_entities: Array[Entity] = []
var theorical_available_entities :
	get:
		return requested_amount - number_of_entities_fielded

func _init(_requested_amount:int):
	requested_amount = _requested_amount
