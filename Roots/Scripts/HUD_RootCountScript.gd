extends Label

var roots = 0
export var max_roots = 100

func _ready():
	text = str(roots) + " / " + str(max_roots)
	
func _process(delta):
	roots = get_tree().get_nodes_in_group("roots").size()
	text = str(roots) + " / " + str(max_roots)
	if (roots >= max_roots):
		print("VOITTO")
		get_tree().change_scene("res://Scenes/WinScreen.tscn")
