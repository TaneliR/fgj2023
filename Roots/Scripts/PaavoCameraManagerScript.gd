extends Node

export var target_node : NodePath
signal average_signal
signal max_distance

func _ready():
	
	if not target_node:
		print("Please set the target node in the inspector.")

	# delay the execution of the function until the next frame
	call_deferred("check_children")

func check_children():
	var randomNode = get_node(target_node)
	var children = randomNode.get_children()
	
	if children.empty():
		print("Waiting for children to be instantiated...")
		call_deferred("check_children")
		
		
	## Calculate the average position between the nodes in the array
		
	var total_x = 0
	var total_y = 0
		
	for node in children:
		total_x += node.position.x
		total_y += node.position.y
		
	var average_x = total_x / children.size()
	var average_y = total_y / children.size()
	
	emit_signal("average_signal", Vector2(average_x, average_y))
	
	
	# Calculate the distance between two of the most distant nodes
	# and emit it as a signal to the camera 
	
	var max_distance = 0
	
	for i in range(children.size()):
		for j in range(i + 1, children.size()):
			# Calculate the distance between the nodes
			var distance = children[i].position.distance_to(children[j].position)
			
			if distance > max_distance:
				max_distance = distance
				
	emit_signal("max_distance", float(max_distance))
	
	print(max_distance)
	# TODO: signal to camera and base the zoom level
