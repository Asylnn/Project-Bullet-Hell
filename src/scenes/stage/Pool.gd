extends Node2D
class_name Pool
var pooling_id_dict = {}
const NUMBER_OF_INSTANTIATION_PER_FRAME = 1

func request_entity_pooling(shooting_order: BaseShootingOrder, id: String, amount: int):
	if pooling_id_dict.has(id):
		pooling_id_dict[id].requested_amount += amount
	else:
		var node = shooting_order.duplicate()
		pooling_id_dict[id] = PoolCensus.new(amount)
		node.name = id
		node.find_child("Timer").queue_free()
		add_child(node)

func free_pool(id: String, number: int):
	pooling_id_dict[id].requested_amount -= number

func put_to_pool(id: String, entity: Entity):
	get_tree().get_first_node_in_group("Field").remove_child(entity)
	pooling_id_dict[id].stocked_entities.append(entity)
	pooling_id_dict[id].number_of_entities_fielded -= 1
	
func report_unfield(id):
	pooling_id_dict[id].number_of_entities_fielded -= 1
	

func has_free_space_for_pooling(id) -> bool:
	#print_tree()
	#print(id)
	#print(find_child(id))
	#print(get_node(id))
	#for child in get_children() :
		#print(child.name == id)
	if pooling_id_dict[id].theorical_available_entities <= pooling_id_dict[id].stocked_entities.size()-2:
		#print("tae", pooling_id_dict[id].theorical_available_entities)
		#print("stock", pooling_id_dict[id].stock)
		return false
	#print("aaaaaaa")
	return true

func _process(delta):
	pass
	#print(delta)
	##for i in NUMBER_OF_INSTANTIATION_PER_FRAME:
	#for node in get_children():
		#if node.name == "phantum bullet":
			##print(node.name, pooling_id_dict[node.name].requested_amount)
			##print(pooling_id_dict[node.name].number_of_entities_fielded)
			##print(pooling_id_dict[node.name] .theorical_available_entities)
			##print(node.get_child_count()-1)
			#if pooling_id_dict[node.name].theorical_available_entities >= node.get_child_count()+1:
				#print("NEW OBJECT!!!")
				#node.construct_bullet()

func has_entity(id) -> bool:
	var node = get_node(id)
	if node :
		if pooling_id_dict[id].stocked_entities.size() > 0 :
			return true
		else :
			return false
	else :
		return false
	
	
func provide_entity(id) :
	var node = get_node(id)
	if pooling_id_dict[id].stocked_entities.size() > 0:
		pooling_id_dict[id].number_of_entities_fielded += 1
		return pooling_id_dict[id].stocked_entities.pop_front()
	
	pooling_id_dict[id].number_of_entities_fielded += 1
	return node.construct_bullet()


func _on_timer_timeout():
	for i in 4:
		for node in get_children():
			if node.name == "spellcard star u":
				#print(node.name, pooling_id_dict[node.name].requested_amount)
				#print(pooling_id_dict[node.name].number_of_entities_fielded)
				#print(pooling_id_dict[node.name] .theorical_available_entities)
				#print(pooling_id_dict[node.name] .stock)
				pass
			if pooling_id_dict[node.name].theorical_available_entities >= pooling_id_dict[node.name].stocked_entities.size():
				pooling_id_dict[node.name].stocked_entities.append(node.construct_bullet())























#extends Node2D
#class_name Pool
#var pooling_id_dict = {}
#const NUMBER_OF_INSTANTIATION_PER_FRAME = 1
#
#func request_entity_pooling(shooting_order: BaseShootingOrder, id: String, amount: int):
	##print("sdddddddddddddddddddddd")
	#if pooling_id_dict.has(id):
		##print("eeeeeeeeeeeeeeeeeeeeee")
		#pooling_id_dict[id].requested_amount += amount
	#else:
		##print("fffffffffffffffffffffff")
		#var node = shooting_order.duplicate()
		#pooling_id_dict[id] = PoolCensus.new(amount)
		#node.name = id
		#node.find_child("Timer").queue_free()
		#add_child(node)
#
#func free_pool(id: String, number: int):
	#pooling_id_dict[id].requested_amount -= number
#
#func put_to_pool(id: String, entity: Entity):
	##print("escaped brikking")
	#entity.reparent(get_node(id))
	##print("bbbbbbbb")
	#
	#entity.is_pooled = true
	#
	##print("previous stock in put to pool : ", pooling_id_dict[id].stock)
	#
	#pooling_id_dict[id].stock += 1
	##print("new stock: ", pooling_id_dict[id].stock)	
	#pooling_id_dict[id].number_of_entities_fielded -= 1
	#
#func report_unfield(id):
	##print("bricked")
	##print("MMAAAYYYYYYBBEEEEEE???????,")
	#
	#pooling_id_dict[id].number_of_entities_fielded -= 1
	#
#
#func has_free_space_for_pooling(id) -> bool:
	##print_tree()
	##print(id)
	##print(find_child(id))
	##print(get_node(id))
	##for child in get_children() :
		##print(child.name == id)
	#if pooling_id_dict[id].theorical_available_entities <= pooling_id_dict[id].stock-2:
		##print("tae", pooling_id_dict[id].theorical_available_entities)
		##print("stock", pooling_id_dict[id].stock)
		#return false
	##print("aaaaaaa")
	#return true
#
#func _process(delta):
	#pass
	##print(delta)
	###for i in NUMBER_OF_INSTANTIATION_PER_FRAME:
	##for node in get_children():
		##if node.name == "phantum bullet":
			###print(node.name, pooling_id_dict[node.name].requested_amount)
			###print(pooling_id_dict[node.name].number_of_entities_fielded)
			###print(pooling_id_dict[node.name] .theorical_available_entities)
			###print(node.get_child_count()-1)
			##if pooling_id_dict[node.name].theorical_available_entities >= node.get_child_count()+1:
				##print("NEW OBJECT!!!")
				##node.construct_bullet()
#
#func has_entity(id) -> bool:
	#var node = get_node(id)
	#print(node)	
	#if node :
		#if pooling_id_dict[node.name].stock > 0 :
			#return true
		#else :
			#return false
	#else :
		#return false
	#
	#
#func provide_entity(id) :
	##print(pooling_id_dict["phantum bullet"].requested_amount)
	##print(pooling_id_dict["phantum bullet"].number_of_entities_fielded)
	##print(pooling_id_dict["phantum bullet"] .theorical_available_entities)
	#var node = get_node(id)
	##print(pooling_id_dict[node.name].stock)
	##print(node.get_child_count())
	##print("stock from size", pooling_id_dict[node.name].entities_internal_id_array.size())
	##print("stock from stock", pooling_id_dict[id].stock)
	#if pooling_id_dict[id].stock > 0:
		#
		##for entity in node.get_children():
			##if entity is Entity and entity.is_pooled :
		##print("bricked is yes life is brick")
		#pooling_id_dict[id].stock -= 1
		##print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
#
		##print("str", str(pooling_id_dict[node.name].entities_internal_id_array.pop_front()))
		##print("int", pooling_id_dict[node.name].entities_internal_id_array.pop_front())
		##print("arr", pooling_id_dict[node.name].entities_internal_id_array)
		##print(pooling_id_dict[node.name])
		##node.print_tree()
		##print(pooling_id_dict[node.name].entities_internal_id_array.size())
		##print(pooling_id_dict[node.name].entities_internal_id_array[0])
		#pooling_id_dict[id].number_of_entities_fielded += 1
		#
		#return node.get_child(1)
	##print("bricked is not ")
	##print("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVv")
	#
	#pooling_id_dict[id].number_of_entities_fielded += 1
	#node.construct_bullet()
	#return node.get_child(1)
#
#
#func _on_timer_timeout():
	##for id in pooling_id_dict :
		##var node = get_node(id)
			###if node.name == "spellcard star u":
				####print(node.name, pooling_id_dict[node.name].requested_amount)
				####print(pooling_id_dict[node.name].number_of_entities_fielded)
				####print(pooling_id_dict[node.name] .theorical_available_entities)
				####print(pooling_id_dict[node.name] .stock)
				###pass
		##if pooling_id_dict[node.name].theorical_available_entities >= pooling_id_dict[node.name].stock:
			##pooling_id_dict[node.name].stock += 1
			###print("NEW OBJECT!!!")
			##node.construct_bullet()
	#for i in 2:
		#for node in get_children():
			#if node.name == "spellcard star u":
				##print(node.name, pooling_id_dict[node.name].requested_amount)
				##print(pooling_id_dict[node.name].number_of_entities_fielded)
				##print(pooling_id_dict[node.name] .theorical_available_entities)
				##print(pooling_id_dict[node.name] .stock)
				#pass
			#if pooling_id_dict[node.name].theorical_available_entities >= pooling_id_dict[node.name].stock:
				#pooling_id_dict[node.name].stock += 1
				#print("NEW OBJECT!!!")
				#node.construct_bullet()
	#pass
