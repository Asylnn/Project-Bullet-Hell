extends InventorySlot
class_name ActiveSpellSlot

signal update_bar(cooldown, id)
var indice : int = -1

func updateSpell(new_spellcard) :
	super(new_spellcard)
	if spellcard != null :
		$"Spell Timer".wait_time = spellcard.cooldown
		update_bar.emit(spellcard.cooldown, indice)
	else :
		$"Spell Timer".stop()

func activate_spell():
	spellcard.fire(get_tree())
	$"Spell Timer".start()

func _enter_tree():
	var levelscene = get_tree().current_scene.get_node("Spell Bar")
	update_bar.connect(levelscene._update_progress_bar)
