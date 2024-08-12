class_name InventorySlot extends Panel

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

## Switch the [SpellCard] of two inventory slots
func switch_spell(spellcard_slot: InventorySlot) -> void:
	var self_spellcard = get_child(0)
	var spellcard = spellcard_slot.get_child(0)
	spellcard.reparent(get_parent()) # To avoid having two Empty Spell Card at the same time
	self_spellcard.reparent(spellcard_slot)
	spellcard.reparent(self)
	self_spellcard.position = Vector2(0,0)
	spellcard.position = Vector2(0,0)
	spell_activation_control(spellcard_slot)
	spell_activation_control(self)

## This function is used to check if the slot is an [ActiveSpellSlot] and in that case call [param activate_spell] or [param desactivate_spell] if a regular [InventorySlot]
func spell_activation_control(slot : InventorySlot) -> void:
	if slot is ActiveSpellSlot:
		slot.activate_spell()
	elif not slot is ActiveSpellSlot :
		slot.desactivate_spell()

## This function is changing the stored [SpellCard]'s [ShootingManager]'s [param shooter_identity] property to SPELLCARD (which enables it to fire)
func activate_spell() -> void:
	var shooting_manager : ShootingManager = get_child(0).find_child("ShootingManager")
	shooting_manager.shooter_identity = ShootingManager.ShooterIdentityEnum.SPELLCARD

## This function is changing the stored [SpellCard]'s [ShootingManager]'s [param shooter_identity] property to INACTIVE_SPELLCARD (which disable it's ability to fire)
func desactivate_spell() -> void:
	get_child(0).find_child("ShootingManager").shooter_identity = ShootingManager.ShooterIdentityEnum.INACTIVE_SPELLCARD

## Check if the stored [SpellCard] is an Empty SpellCard (no firing abilities)
func _is_slot_empty(): return get_child(0).name == "Empty SpellCard"
