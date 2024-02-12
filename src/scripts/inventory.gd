extends GridContainer

const INVENTORY_SIZE = 12

func _ready():
	for i in range(INVENTORY_SIZE):
		var panel : InventorySlot = preload("res://src/scenes/inventory_slot.tscn").instantiate()
		
		add_child(panel)
	
	
		
	var AI = preload("res://src/scenes/bullets/ai.tscn")
	var SHI = preload("res://src/scenes/bullets/shi.tscn")
	var spell_ai = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/Friendly Bullet.png", 0.2)#SpellCard.new("res://Sprites/Friendly Bullet.png", 0.2)
	var spell_shi = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/Friendly Bullet 2.png", 0.5)
	var shooting_pattern_ai = preload("res://src/scenes/shooting orders/shoot_simple.tscn").instantiate()._construct(AI, 0, 1, 1, 0, 0, Vector2(0,-1))
	var movement_pattern_ai = preload("res://src/scenes/Movement Orders/movement_line.tscn").instantiate()._construct(Vector2(0, -1), 2000, true)
	
	var movement_pattern_shi = movement_pattern_ai.duplicate(15)
	var shooting_pattern_shi = shooting_pattern_ai.duplicate(15)
	shooting_pattern_ai.damage = 3
	shooting_pattern_shi.damage = 10
	shooting_pattern_shi.bullet_scene = SHI
	shooting_pattern_ai.get_node("Timer").stop()
	shooting_pattern_shi.get_node("Timer").stop()
	shooting_pattern_ai.add_child(movement_pattern_ai)
	shooting_pattern_shi.add_child(movement_pattern_shi)
	spell_ai.add_child(shooting_pattern_ai)
	spell_shi.add_child(shooting_pattern_shi)
	_add_item(spell_ai)
	_add_item(spell_ai.duplicate())
	_add_item(spell_ai.duplicate())
	_add_item(spell_shi)
	_add_item(spell_shi.duplicate())
	

	
func _add_item(spellcard):
	var inventory = get_children()
	for i in len(inventory) :
		if not inventory[i].has_spell :
			add_child(spellcard)
			#test with just "spellcard"
			inventory[i].updateSpell(spellcard)
			return
