extends Label

var roots = 0
export var max_roots = 500

func _ready():
	print (roots)
	text = str(roots) + " / " + str(max_roots)
	
func _process(delta):
	text = str(get_tree().get_nodes_in_group("roots").size())
