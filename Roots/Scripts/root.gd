extends Node2D

const SPEED = 80

onready var rootHead = get_child(0)
onready var rootTail = get_child(1)
onready var rng = RandomNumberGenerator.new()
onready var timer = Timer.new()
onready var direction
onready var finished = false
onready var spawnPoint = rootHead.position

onready var coll = CollisionShape2D
onready var color = Color8(14, 103, 15)
onready var timer2 = Timer.new()

onready var dead = false

var nodeDepth = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("roots")
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(0, 1))
	var line = rootTail.get_child(1)
	var darken = nodeDepth * 15 - rootHead.position.y
	var offsets = [0, 1]
	var newColor = Color8(14 + darken, 103 + darken, 15 + darken)
	var colors = PoolColorArray([color, newColor])
	var newGradient = line.gradient.duplicate()
	newGradient.offsets = offsets
	newGradient.colors = colors
	line.gradient = newGradient
	
	line.add_point(spawnPoint)
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer2.connect("timeout", self, "_on_Timer2_timeout")
	
	add_child(timer)
	add_child(timer2)
	timer.start(rng.randi_range(2, 5))
	timer2.start(1)

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

func _on_Timer_timeout():
	if (!finished):
		get_node("/root/Node2D").addRoot(rootHead.position, rootHead.global_position, direction, nodeDepth, self)
		finished = true
		rootHead.get_child(2).emitting = false
		rootHead.get_child(0).disabled = true
		rootHead.move_and_collide(Vector2.ZERO)
		
func _on_Timer2_timeout():
	self.get_node("RootHead").set_collision_layer(17)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (!finished):
		#var dir = (get_global_mouse_position() - global_position).normalized()
			
		var collision = rootHead.move_and_collide(((direction * SPEED) * delta ).rotated(rng.randf_range(-PI / 2, PI / 2)))
		_draw()
		if collision:
			disableRoot()
			print("I collided with ", collision.collider.name)
			
	
func generateNextWaypoint(previousDirection):
	pass
	
func disableRoot():
	finished = true
	timer.stop()
	
	self.get_node("/root/Node2D").removeRoot(self)
	rootHead.get_child(2).emitting = false
	rootHead.get_child(0).disabled = true
	rootHead.move_and_collide(Vector2() * 0)
	
func wither():
	get_node("RootTail/TailLine").gradient.set_color(0, Color(0.4, 0.26, 0.11, 1))
	get_node("RootTail/TailLine").gradient.set_color(1, Color(0.4, 0.26, 0.11, 1))

func killRoot():
	dead = true
	disableRoot()
	wither()
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	var hadChildRoot = false
	for child in get_children():
		if (child.is_in_group("roots")):
			hadChildRoot = true
			child.killRoot()
	if (!hadChildRoot):
		cleanUp()
		
func cleanUp():
	var t = Timer.new()
	t.set_wait_time(0.25)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if (get_parent().dead):
		var hasChildren = false
		for child in get_parent().get_children():
			if (child.is_in_group("roots")):
				hasChildren = true
		if !hasChildren:
			get_parent().cleanUp()
	t.set_wait_time(0.20)	
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
