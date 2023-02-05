extends Node2D

var maxNodes = 5 
var rootNodes = []
var rootPrefab = preload("res://Prefabs/Root.tscn")
var molePrefab = preload("res://Prefabs/mole.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	rootNodes.append(get_node("Root"))
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_down"):
		addMole()

func addMole():
	var newMole = molePrefab.instance()
	newMole.position = Vector2(500, 500)
	add_child(newMole)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func removeRoot(root):
	pass
	#root.get_parent().remove_from_group("roots")

func addRoot(position, globalPosition, direction, depth, rootNode):
#	if get_tree().get_nodes_in_group("roots").size() < 20:

	var newRoot = rootPrefab.instance()
	var newRoot2 = rootPrefab.instance()
	newRoot.nodeDepth = depth + 1
	newRoot2.nodeDepth = depth + 1
	var newDirection = Vector2(direction.x + 0.1, direction.y + 0.1)
	newRoot.position = position
	newRoot2.position = position
	newRoot.direction = direction + newDirection
	newRoot2.direction = (direction + newDirection) / 2
	rootNode.add_child(newRoot)
	var t = Timer.new()
	t.set_wait_time(0.25)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	rootNode.add_child(newRoot2)
