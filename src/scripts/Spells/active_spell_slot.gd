extends InventorySlot
class_name ActiveSpellSlot

signal update_bar(cooldown, id, isSpellRemoved)
var indice : int = -1

#func updateSpell(new_spellcard = false) :
	#super(new_spellcard)
	#if _is_slot_empty() :
		#update_bar.emit(new_spellcard.cooldown, indice, false)
	#else :
		#update_bar.emit(1, indice, true)



func _enter_tree():
	var levelscene = get_tree().current_scene.get_node("Spell Bar")
	#update_bar.connect(levelscene._update_progress_bar)
