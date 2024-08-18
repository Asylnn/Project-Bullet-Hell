class_name UI extends VBoxContainer
##
## This class bring together all the UI elements
##
## For now though, it only have the scoring system and the mana bar, in the futur it should have the
## player's lifes and maybe the boss bar

##Total score of the player for that playthrough 
var total_score : int = 0

## Texture to apply when the mana bar is full
var full_bar_text : Texture2D = preload("res://Sprites/svg/life bar progress.svg")
var prgress_bar_text : Texture2D = preload("res://Sprites/svg/life bar under.svg")
##How much mana does each bar need to go full
const MANA_PER_BAR : int = 10

##When an enemy dies, update core
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

##Update the mana bar progress
func _update_mana(mana : int):
	$"ManaBar/Mana1".value = mana
	$"ManaBar/Mana2".value = mana
	$"ManaBar/Mana3".value = mana
	$"ManaBar/Mana4".value = mana
	if $"ManaBar/Mana1".value >= $"ManaBar/Mana1".max_value : $"ManaBar/Mana1".texture_progress = full_bar_text
	else : $"ManaBar/Mana1".texture_progress = prgress_bar_text
	if $"ManaBar/Mana2".value >= $"ManaBar/Mana2".max_value : $"ManaBar/Mana2".texture_progress = full_bar_text
	else : $"ManaBar/Mana2".texture_progress = prgress_bar_text
	if $"ManaBar/Mana3".value >= $"ManaBar/Mana3".max_value : $"ManaBar/Mana3".texture_progress = full_bar_text
	else : $"ManaBar/Mana3".texture_progress = prgress_bar_text	
	if $"ManaBar/Mana4".value >= $"ManaBar/Mana4".max_value : $"ManaBar/Mana4".texture_progress = full_bar_text
	else : $"ManaBar/Mana4".texture_progress = prgress_bar_text

