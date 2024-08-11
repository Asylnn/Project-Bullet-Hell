extends Label

func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr




func _on_timer_timeout():
	var entities = get_all_children(get_parent()).filter(func(node): return node is Node2D)
	set_text(str(len(entities)))
	
