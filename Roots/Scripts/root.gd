extends Node2D

const SPEED = 50

onready var rootHead = get_child(0)
onready var rootTail = get_child(1)
onready var rng = RandomNumberGenerator.new()
onready var timer = Timer.new()
onready var direction
onready var finished = false
onready var spawnPoint = rootHead.position

onready var coll = CollisionShape2D
onready var color = Color8(14, 103, 15)

var nodeDepth = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(0, 1))
	var line = rootTail.get_child(1)
	var darken = nodeDepth * 15
	var offsets = [0, 1]
	var newColor = Color8(14 + darken, 103 + darken, 15 + darken)
	var colors = PoolColorArray([color, newColor])
	print(colors)
	var newGradient = line.gradient.duplicate()
	newGradient.offsets = offsets
	newGradient.colors = colors
	line.gradient = newGradient
	
	line.add_point(spawnPoint)
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	add_child(timer)
	timer.start(rng.randi_range(2, 6))

func _draw():
	var line = rootTail.get_child(1)
	var collider = rootTail.get_child(0)
	#var newColorPool = generateColor(nodeDepth)
	line.add_point(rootHead.position)
	var newColl = collider.duplicate()
	var newShape = collider.shape.duplicate()
	newShape.a = spawnPoint
	newShape.b = rootHead.position
	collider.shape = newShape

func _process(delta):
	pass

func _on_Timer_timeout():
	print(rootHead.global_position)
	if (!finished):
		self.get_parent().addRoot(rootHead.global_position, direction, nodeDepth)
		self.get_parent().removeRoot(self)
		finished = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (!finished):
		var collision = rootHead.move_and_collide(direction * delta * SPEED)
		_draw()
		if collision:
			finished = true
			timer.stop()
			rootHead.move_and_collide(Vector2() * 0)
			rootHead.get_child(0).disabled = true
			print("I collided with ", collision.collider.name)
			
	
func generateNextWaypoint(previousDirection):
	pass
	
