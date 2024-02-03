extends Control

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
	pass # Replace with function body.


func _on_main_menu_button_mouse_entered():
	$"Main Menu Button/Main Menu".label_settings = load("res://src/other/font_pause_menu_over.tres")
	pass # Replace with function body.


func _on_main_menu_button_mouse_exited():
	$"Main Menu Button/Main Menu".label_settings = load("res://src/other/font_pause_menu.tres")
	pass # Replace with function body.



func _on_restart_button_pressed():
	get_tree().paused = false	
	get_tree().change_scene_to_file("res://src/scenes/stage_1.tscn")
	pass # Replace with function body.


func _on_restart_button_mouse_entered():
	$"Restart Button/Restart".label_settings = load("res://src/other/font_pause_menu_over.tres")
	pass # Replace with function body.


func _on_restart_button_mouse_exited():
	$"Restart Button/Restart".label_settings = load("res://src/other/font_pause_menu.tres")
	pass # Replace with function body.
