extends ProgressBar

func update_bar(health: float):
	print("health", health)
	print("max value", max_value)
	value = health
	
func boss_spawned(max_health: float): 
	visible = true
	max_value = max_health
	value = max_health
	
func boss_died(score): visible = false
	
