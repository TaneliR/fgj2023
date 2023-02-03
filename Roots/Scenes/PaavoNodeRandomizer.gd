extends Node2D

func _ready():
	for i in range(2):
		
		# Creates two random nodes with random positions and red
		#rectangles for debugging, and adds them as child nodes
		
		var randNode = Node2D.new()
		randNode.position = Vector2(rand_range(-100, 100), rand_range(-100, 100))
		
		var color_rect = ColorRect.new()
		color_rect.rect_size = Vector2(10, 10)
		color_rect.color = Color(1, 0, 0)
		
		randNode.add_child(color_rect)
		add_child(randNode)
