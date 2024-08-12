class_name UI extends VBoxContainer

var total_score : int = 0

func _on_enemy_died(score : int):
	total_score += score
	$"Score/Score".text = str(total_score)

func _update_mana(mana : int):
	$"Mana/Mana".text = str(mana)
