extends Label

var dead_roots = 0

export var max_dead = 5

func _ready():
	text = str(dead_roots) + " / " + str(max_dead)
	
# on signal x
#	text = dead_roots +1
