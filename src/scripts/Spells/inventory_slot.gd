extends Panel
class_name InventorySlot

func _is_slot_empty():
	return get_child(0).name == "Empty SpellCard"

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if Input.is_action_pressed("Shift Move "):
			var empty_spell_slot
			if self is ActiveSpellSlot:
				empty_spell_slot = get_tree().get_first_node_in_group("Inventory")._get_first_free_slot()
			else: 
				empty_spell_slot = get_tree().get_first_node_in_group("Spell Bar")._get_first_free_slot()
			if empty_spell_slot:
				switch_spell(empty_spell_slot)
		else :
			var grabbedSpellSlot = get_tree().get_first_node_in_group("GrabbedSpellSlot")
			switch_spell(grabbedSpellSlot)

func switch_spell(spellcard_slot):
	var self_spellcard = get_child(0)
	var spellcard = spellcard_slot.get_child(0)
	spellcard.reparent(get_parent()) # To avoid having two Empty Spell Card at the same time
	self_spellcard.reparent(spellcard_slot)
	spellcard.reparent(self)
	self_spellcard.position = Vector2(0,0)
	spellcard.position = Vector2(0,0)

