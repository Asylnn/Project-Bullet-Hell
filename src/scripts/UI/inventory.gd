extends GridContainer

const INVENTORY_SIZE = 12							## Inventory size
var mana : int = 0									## Amount of mana stored
const MAX_MANA = 42

signal update_mana(mana: int)						## Used when the amount of mana stored changed. used for communicating with UI

func _ready():
	var ui = get_tree().get_first_node_in_group("UI")
	update_mana.connect(ui._update_mana)
	get_tree().get_first_node_in_group("Player").recieved_collectible.connect(_recieved_collectible)
	for i in range(INVENTORY_SIZE):
		var panel : InventorySlot = preload("res://src/scenes/spells/inventory_slot.tscn").instantiate()
		panel.name = "Inventory Slot " + str(i)
		add_child(panel)
	
	
		
	#var AI = preload("res://src/scenes/bullets/ai.tscn")
	#var SHI = preload("res://src/scenes/bullets/shi.tscn")
	#var STAR = preload("res://src/scenes/bullets/star.tscn")
	#var ARROW = preload("res://src/scenes/bullets/arrow.tscn")
	#var spell_ai = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/Friendly Bullet.png", 0.2)#SpellCard.new("res://Sprites/Friendly Bullet.png", 0.2)
	#var spell_shi = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/Friendly Bullet 2.png", 0.5)
	#var spell_star = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/star.png", 0.2)
	#var spell_homing = preload("res://src/scenes/bullets/spellcard.tscn").instantiate()._construct("res://Sprites/arrow.png", 0.1)
	#var shooting_pattern_ai = preload("res://src/scenes/shooting orders/shoot_simple.tscn").instantiate()._construct(AI, 0, 1, 1, 0, 0, Vector2(0,-1))
	#var shooting_pattern_star = preload("res://src/scenes/shooting orders/shoot_random.tscn").instantiate()._construct(STAR, 0, 30, 2, Vector2(0,-1))
	#var movement_pattern_ai = preload("res://src/scenes/Movement Orders/movement_line.tscn").instantiate()._construct(Vector2(0, -1), 2000, true)
	#var movement_pattern_homing = preload("res://src/scenes/Movement Orders/movement_homing.tscn").instantiate()._construct(true, MovementHoming.targetType.ENEMY, 1000, 10)
	#movement_pattern_homing.rotate = true
	#var movement_pattern_shi = movement_pattern_ai.duplicate(15)
	#var movement_pattern_star = movement_pattern_ai.duplicate(15)
	#var shooting_pattern_shi = shooting_pattern_ai.duplicate(15)
	#var shooting_pattern_homing = shooting_pattern_ai.duplicate(15)
	#shooting_pattern_ai.damage = 3
	#shooting_pattern_shi.damage = 10
	#shooting_pattern_star.damage = 2
	#shooting_pattern_homing.damage = 2
	#shooting_pattern_shi.bullet_scene = SHI
	#shooting_pattern_homing.bullet_scene = ARROW
	#shooting_pattern_ai.get_node("Timer").stop()
	#shooting_pattern_shi.get_node("Timer").stop() #wait we should just put autostart on off right?
	#shooting_pattern_star.get_node("Timer").stop()
	#shooting_pattern_ai.add_child(movement_pattern_ai)
	#shooting_pattern_shi.add_child(movement_pattern_shi)
	#shooting_pattern_star.add_child(movement_pattern_star)
	#shooting_pattern_homing.add_child(movement_pattern_homing)
	#spell_ai.add_child(shooting_pattern_ai)
	#spell_shi.add_child(shooting_pattern_shi)
	#spell_star.add_child(shooting_pattern_star)
	#spell_homing.add_child(shooting_pattern_homing)
	#_add_item(spell_ai)
	#_add_item(spell_ai.duplicate())
	#_add_item(spell_shi)
	#_add_item(spell_star)
	#_add_item(spell_star.duplicate())
	#_add_item(spell_star.duplicate())
	#_add_item(spell_star.duplicate())
	#_add_item(spell_shi.duplicate())
	#_add_item(spell_homing)
	#_add_item(spell_homing.duplicate())
	#_add_item(spell_homing.duplicate())
	#_add_item(spell_homing.duplicate())
	_add_item(preload("res://src/scenes/spells/spellcard_ai.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_ai.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_shi.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_shi.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_arrow.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_arrow.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_star.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_star.tscn").instantiate())
	_add_item(preload("res://src/scenes/spells/spellcard_ultimate_star.tscn").instantiate())
	#print_tree()


func _recieved_collectible(collectible : Collectible):
	if collectible is ManaFlame:
		mana = max(collectible.mana + mana, MAX_MANA)
		update_mana.emit(mana)
	
	
func _get_first_free_slot():
	for inventory_slot in get_children():
		if inventory_slot._is_slot_empty():
			return inventory_slot
	return null

func _add_item(spellcard):
	var slot = _get_first_free_slot()
	
	if slot :

		slot.find_child("Empty SpellCard").free()
		slot.add_child(spellcard)
