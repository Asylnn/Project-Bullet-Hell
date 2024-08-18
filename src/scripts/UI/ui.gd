class_name UI extends VBoxContainer

var total_score : int = 0
const MANA_PER_BAR : int = 10


func _on_enemy_died(score : int):
	total_score += score
	$"Score/Score".text = str(total_score)

func _ready():
	$ManaBar/Mana1.min_value = 0
	$ManaBar/Mana1.max_value = 10
	$ManaBar/Mana2.min_value = 10
	$ManaBar/Mana2.max_value = 20
	$ManaBar/Mana3.min_value = 20
	$ManaBar/Mana3.max_value = 30
	$ManaBar/Mana4.min_value = 30
	$ManaBar/Mana4.max_value = 40

func _update_mana(mana : int):
	print(mana)
	$"ManaBar/Mana1".value = mana
	$"ManaBar/Mana2".value = mana
	$"ManaBar/Mana3".value = mana
	$"ManaBar/Mana4".value = mana
