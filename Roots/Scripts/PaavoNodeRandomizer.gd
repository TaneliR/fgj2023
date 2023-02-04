extends Node2D

func _ready():
	for _i in range(5):
		
		var randNode = Node2D.new()
		
		randomize()
		var randX = rand_range(-1000, 1000)
		randomize()
		var randY = rand_range(-1000, 1000)
		
		randNode.position = Vector2(randX,randY)
		
		var color_rect = ColorRect.new()
		color_rect.rect_size = Vector2(100, 100)
		color_rect.color = Color(1, 0, 0)
		
		randNode.add_child(color_rect)
		add_child(randNode)
