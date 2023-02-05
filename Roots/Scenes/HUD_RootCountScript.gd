extends Label

var roots = 0

export var max_roots = 500

func _ready():
	text = str(roots) + " / " + str(max_roots)
	
# on signal x
#	text = roots +1
