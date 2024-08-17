class_name Pool extends Node2D
static var pooling_id_dict = {}
const NUMBER_OF_INSTANTIATION_PER_FRAME_PER_ENTITY = 4

static func request_new_entity_pooling(constructor: BulletConstructor, id: String, amount: int):
	pooling_id_dict[id] = PoolCensus.new(amount)
	pooling_id_dict[id].constructor = constructor

static func request_entity_pooling(id: String, amount: int) -> void:
	pooling_id_dict[id].requested_amount += amount

static func free_pool(id: String, number: int) -> void: pooling_id_dict[id].requested_amount -= number
static func report_unfield(id) -> void: pooling_id_dict[id].number_of_entities_fielded -= 1

static func put_to_pool(id: String, entity: Entity) -> void:
	pooling_id_dict[id].stocked_entities.append(entity)
	pooling_id_dict[id].number_of_entities_fielded -= 1
	

	

static func has_free_space_for_pooling(id) -> bool:

	if pooling_id_dict[id].theorical_available_entities  <= pooling_id_dict[id].stocked_entities.size()-2:
		return false
	return true

static func has_entity(id) -> bool: return pooling_id_dict.has(id)
	
	
static func provide_entity(id) -> Bullet:
	if pooling_id_dict[id].stocked_entities.size() > 0:
		pooling_id_dict[id].number_of_entities_fielded += 1
		return pooling_id_dict[id].stocked_entities.pop_front()
	
	pooling_id_dict[id].number_of_entities_fielded += 1
	return pooling_id_dict[id].constructor.construct_bullet()


func _on_timer_timeout():
	for i in NUMBER_OF_INSTANTIATION_PER_FRAME_PER_ENTITY:
		for id in pooling_id_dict:
			#print("ra", pooling_id_dict[node.name].requested_amount)
			if id == "spellcard star u":
				#print(node.name, pooling_id_dict[node.name].requested_amount)
				#print(pooling_id_dict[node.name].number_of_entities_fielded)
				#print(pooling_id_dict[node.name] .theorical_available_entities)
				#print(pooling_id_dict[node.name] .stock)
				pass
			#print(node)
			#print(node.name)
			if pooling_id_dict[id].theorical_available_entities >= pooling_id_dict[id].stocked_entities.size():
				pooling_id_dict[id].stocked_entities.append(pooling_id_dict[id].constructor.construct_bullet())
