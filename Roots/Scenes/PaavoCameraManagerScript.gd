extends Node

export var target_node : NodePath
signal average_signal

func _ready():
	var randomNode = get_node(target_node)
	
	if not target_node:
		print("Please set the target node in the inspector.")
		return

	# delay the execution of the function until the next frame
	call_deferred("check_children")

func check_children():
	var randomNode = get_node(target_node)
	var children = randomNode.get_children()
	
	var total_x = 0
	var total_y = 0
	
	# check if the children have been instantiated
	if children.empty():
		print("Waiting for children to be instantiated...")
		call_deferred("check_children")
		return
		
	for node in children:
		total_x += node.position.x
		total_y += node.position.y
		
	var average_x = total_x / children.size()
	var average_y = total_y / children.size()
	
	print("Average position:", Vector2(average_x, average_y))
	emit_signal("average_signal", Vector2(average_x, average_y))
