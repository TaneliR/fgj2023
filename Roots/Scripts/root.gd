extends Node

var from = Vector2(50,20)
var to = Vector2(190, 190)
var color = color(255, 255, 255)
var start = Vector2(1, 0)
var next = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	_draw()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_line(from, to, col)
	from += Vector2(0, 50)
	to += Vector2(0, 50)

func generateNextWaypoint(previousDirection):
	
	
