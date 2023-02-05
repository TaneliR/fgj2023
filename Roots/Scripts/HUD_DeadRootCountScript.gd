extends Label

var dead_roots = 0

export var max_dead = 5

func _ready():
	text = str(dead_roots) + " / " + str(max_dead)
	
func on_hit():
	dead_roots = dead_roots + 1
	text = str(dead_roots) + " / " + str(max_dead)
	if (dead_roots >= max_dead):
		get_tree().change_scene("res://Scenes/LoseScreen.tscn")
