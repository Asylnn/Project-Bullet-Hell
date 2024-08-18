class_name SpellCardDescription extends Control
const ShotTypeString = {
	SpellCard.ShotType.Focus: "Focus",
	SpellCard.ShotType.Homing: "Homing",
	SpellCard.ShotType.Spread: "Spread",
	SpellCard.ShotType.Mixed: "Mixed"
}

func update_description(spellcard: SpellCard) : # Void
	var order : BaseShootingOrder = spellcard.find_child("ShootingManager").get_child(0)
	$Icon.texture = order.bullet_scene.instantiate().find_child("Sprite2D").texture
	$Name.text = spellcard.spellcard_name
	visible = true 
	$Container/ValueContainer/Augment.text = "None"
	$Container/ValueContainer/ShotType.text = ShotTypeString[spellcard.shot_type]
	var rof = floor(10/order.time_between_each_attacks)/10
	$Container/ValueContainer/RoF.text = str(rof)
	var damage = order.damage
	$Container/ValueContainer/ProjectileDamage.text = str(damage)
	var nop = 1
	if "nbOfWaves" in order : nop *= order.nbOfWaves
	if "nbOfShots" in order : nop *= order.nbOfShots
	$Container/ValueContainer/NoP.text = str(nop)
	$Container/ValueContainer/DPS.text = str(floor(rof*nop*damage))
