extends GridContainer

#spellSlot[i][1] Is the spell
#spellSlot[i][0] Is the bar
var spellSlots : Array

#func(spell): return spell is ActiveSpellSlot and spell.spellcard != null
func _ready():
	var TempSpellSlots = get_children().filter(func(spell): return spell is ActiveSpellSlot)
	for i in len(TempSpellSlots) : 
		TempSpellSlots[i].indice = i
		spellSlots.append([get_child(i), TempSpellSlots[i]])

#var aaa = func(spell):
	#print(spell is ActiveSpellSlot)
	#return spell is ActiveSpellSlot

func _process(delta):
	for i in len(spellSlots):
		var spellSlot = spellSlots[i][1]
		if spellSlot.has_spell:
			var bar = spellSlots[i][0]
			var time_left = spellSlot.get_node("Spellcard/Timer").time_left
			bar.value = time_left
			if time_left == 0 && Input.is_action_pressed("shoot"):
				spellSlot.activate_spell()

func _get_first_free_slot():
	for i in len(spellSlots):
		var spellSlot = spellSlots[i][1]
		if not spellSlot.has_spell:
			return spellSlot
	return null

func _update_progress_bar(cooldown, id, isSpellRemoved):
	if isSpellRemoved:
		spellSlots[id][0].value = 0
	else :
		spellSlots[id][0].max_value = cooldown


#func shoot():
	#for i in len(spellSlots):
		#var spellSlot = spellSlots[i][1]
		#var bar = spellSlots[i][0]
		#print(bar.value)
		#if spellSlot.spellcard != null :
			#var time_left = spellSlot.get_node("Spell Timer").time_left
			#bar.value = time_left
			#if time_left == 0:
				#spellSlot.activate_spell()
				
			
		

			
	#var bulletClass = preload("res://src/scenes/friendly_bullet.tscn")
	#var shootingPattern = preload("res://src/scenes/bullet_spawner.tscn").instantiate()
	#add_child(shootingPattern)
	#shootingPattern.shoot_simple(get_parent(), 1, 1, 0, 0, 2000,bulletClass, Vector2(0, -1))
