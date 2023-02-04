extends Label

var timer = 0
var timer_node

func _ready():
	timer_node = get_node("../Timer")
	timer_node.connect("timeout", self, "timeout")
	set_text("0")
	timer_node.start()

func timeout():
	timer += 1
	set_text(str(timer))
