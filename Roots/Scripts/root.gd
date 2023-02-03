extends Node2D

const SPEED = 25

onready var rootHead = get_child(0)
onready var rootTail = get_child(1)

onready var timer = Timer.new()
onready var direction = Vector2(rand_range(-1, 1), rand_range(0, 1))
onready var finished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rootTail.get_child(1).add_point(self.get_parent().position)
	#timer.connect("timeout", get_parent(), "_on_Timer_timeout")
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	add_child(timer)
	timer.start(rand_range(2, 10))
	
	pass # Replace with function body.

func _draw():
	var line = rootTail.get_child(1)
	line.add_point(rootHead.position)
	pass

func _process(delta):
	_draw()
	pass

func _on_Timer_timeout():
	print(rootHead.global_position)
	if (!finished):
		self.get_parent().addRoot(rootHead.global_position, direction)
		finished = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (!self.finished):
		var collision = rootHead.move_and_collide(direction * delta * SPEED)
		if collision:
			self.finished = true
			rootHead.disabled = true
			print("I collided with ", collision.collider.name)
	else:
		var collision = rootHead.move_and_collide(Vector2() * 0)
	pass
	
func generateNextWaypoint(previousDirection):
	pass
	
