extends Panel
class_name InventorySlot

var spellcard : SpellCard = null

func _on_gui_input(event):
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			#if spellcard != null :
			var grabbedSpellSlot = get_tree().get_first_node_in_group("GrabbedSpellSlot")
			var grabbedSpell = grabbedSpellSlot.spellcard
			grabbedSpellSlot.updateSpell(spellcard)
			updateSpell(grabbedSpell)


func updateSpell(new_spellcard):
	spellcard = new_spellcard
	if spellcard != null :
		$"Spell Icon".texture = load(spellcard.texture)
	else : 
		$"Spell Icon".texture = null
