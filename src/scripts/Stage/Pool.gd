extends Node2D
class_name Pool
var pooling_id_dict = {}
const NUMBER_OF_INSTANTIATION_PER_FRAME = 1

func request_new_entity_pooling(constructor: BulletConstructor, id: String, amount: int):
	pooling_id_dict[id] = PoolCensus.new(amount)
	constructor.name = id
	add_child(constructor)

func request_entity_pooling(id: String, amount: int) -> void:
	pooling_id_dict[id].requested_amount += amount

func free_pool(id: String, number: int) -> void: pooling_id_dict[id].requested_amount -= number
func report_unfield(id) -> void: pooling_id_dict[id].number_of_entities_fielded -= 1

func put_to_pool(id: String, entity: Entity) -> void:
	get_tree().get_first_node_in_group("Field").remove_child(entity)
	pooling_id_dict[id].stocked_entities.append(entity)
	pooling_id_dict[id].number_of_entities_fielded -= 1
	

	

func has_free_space_for_pooling(id) -> bool:

	if pooling_id_dict[id].theorical_available_entities  <= pooling_id_dict[id].stocked_entities.size()-2:
		return false
	return true

func has_entity(id) -> bool: return has_node(id)
	
	
func provide_entity(id) -> Bullet:
	var node = get_node(id)
	if pooling_id_dict[id].stocked_entities.size() > 0:
		pooling_id_dict[id].number_of_entities_fielded += 1
		return pooling_id_dict[id].stocked_entities.pop_front()
	
	pooling_id_dict[id].number_of_entities_fielded += 1
	return node.construct_bullet()


func _on_timer_timeout():
	for i in 4:
		for node in get_children():
			#print("ra", pooling_id_dict[node.name].requested_amount)
			if node.name == "spellcard star u":
				#print(node.name, pooling_id_dict[node.name].requested_amount)
				#print(pooling_id_dict[node.name].number_of_entities_fielded)
				#print(pooling_id_dict[node.name] .theorical_available_entities)
				#print(pooling_id_dict[node.name] .stock)
				pass
			#print(node)
			#print(node.name)
			if pooling_id_dict[node.name].theorical_available_entities >= pooling_id_dict[node.name].stocked_entities.size():
				pooling_id_dict[node.name].stocked_entities.append(node.construct_bullet())
