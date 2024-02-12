extends Panel
class_name InventorySlot

var has_spell = false

func _on_gui_input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		var grabbedSpellSlot = get_tree().get_first_node_in_group("GrabbedSpellSlot")
		var grabbedSpellCard = false
		var spellcard = false
		if Input.is_action_pressed("Shift Move "):
			if not self is ActiveSpellSlot:
				var spell_bar = get_tree().get_first_node_in_group("Spell Bar")
				print(spell_bar)
				grabbedSpellSlot = spell_bar._get_first_free_slot()
			if self is ActiveSpellSlot:
				var inventory = get_tree().get_first_node_in_group("Inventory")
				grabbedSpellSlot = inventory._get_first_free_slot()
		if not grabbedSpellSlot : #If the inventory or spell_bar is full, do nothing
			return
		if grabbedSpellSlot.has_spell :
			print(grabbedSpellSlot)
			print(grabbedSpellSlot.get_child(1))
			grabbedSpellCard = grabbedSpellSlot.get_child(1)
		if has_spell :
			print("hello")
			print(get_children())			
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
