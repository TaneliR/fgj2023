extends Node2D

var rootNodes = []
var rootPrefab = preload("res://Prefabs/Root.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	rootNodes.append(get_node("Root"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func addRoot(position, direction):
	var newRoot = rootPrefab.instance()
	var newRoot2 = rootPrefab.instance()
	var newDirection = Vector2(direction.x + 0.1, direction.y + 0.1)
	newRoot.position = position
	newRoot2.position = position
	newRoot.direction = newDirection
	newRoot2.direction = (direction + newDirection) / 2
	add_child(newRoot)
	add_child(newRoot2)
	rootNodes.append(newRoot)
	rootNodes.append(newRoot2)
	pass
