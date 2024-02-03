extends GridContainer

const INVENTORY_SIZE = 12

func _ready():
	for i in range(INVENTORY_SIZE):
		var panel : InventorySlot = preload("res://src/scenes/inventory_slot.tscn").instantiate()
		
		add_child(panel)
	
	
		
	var bulletClass = preload("res://src/scenes/friendly_bullet.tscn").instantiate()
	var spell1 = SpellCard.new("res://Sprites/Friendly Bullet.png", bulletClass, "Ai", 4 , 0.2)
	var spell2 = SpellCard.new("res://Sprites/Friendly Bullet 2.png", bulletClass, "Ai", 12 , 0.5)
	_add_item(spell1)
	_add_item(spell1)
	_add_item(spell1)
	_add_item(spell2)
	_add_item(spell2)
	

	
func _add_item(spellcard: SpellCard):
	var inventory = get_children()
	for i in len(inventory) :
		if inventory[i].spellcard == null :
			inventory[i].updateSpell(spellcard)
			return
