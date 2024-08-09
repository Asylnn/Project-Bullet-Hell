extends Resource
class_name PoolCensus 

var requested_amount: int
var number_of_entities_fielded: int = 0
var stock : int = 0
var stocked_entities: Array[Entity] = []
var theorical_available_entities :
	get:
		return requested_amount - number_of_entities_fielded

func _init(_requested_amount:int):
	requested_amount = _requested_amount
