extends Panel
class_name InventorySlot

var has_spell = false

func _on_gui_input(event):
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			#if spellcard != null :
			var grabbedSpellSlot = get_tree().get_first_node_in_group("GrabbedSpellSlot")
			var grabbedSpellCard = false
			var spellcard = false
			if grabbedSpellSlot.has_spell :
				print(grabbedSpellSlot)
				print(grabbedSpellSlot.get_child(1))
				grabbedSpellCard = grabbedSpellSlot.get_child(1)
			
			print("hello???", has_spell)
			if has_spell :
				print("hello")
				print(get_child(1))
				spellcard = get_child(1)
			grabbedSpellSlot.updateSpell(spellcard)
			updateSpell(grabbedSpellCard)

func updateSpell(new_spellcard = false):
	print("haspell ", has_spell, " kkk ", new_spellcard, " uuuu ", self)
	if(not new_spellcard):
		has_spell = false
		$"Spell Icon".texture = null
	else : 
		#var name = new_spellcard.name
		has_spell = true
		new_spellcard.reparent(self)
		new_spellcard.name = "Spellcard"
		$"Spell Icon".texture = load(new_spellcard.iconPath)
		print("haspell22! ", new_spellcard)
