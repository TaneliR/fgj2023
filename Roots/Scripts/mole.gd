extends KinematicBody2D

export (int) var speed = 50
var hits = 10

onready var target = position
onready var rng = RandomNumberGenerator.new()
var velocity = Vector2()

func _ready():
	rng.randomize()
	add_to_group("moles")
	get_target()
	
func get_target():
	var targets = get_tree().get_nodes_in_group("roots")
	print(targets)
	var randIndex = rng.randi_range(0, targets.size()-1)
	var targetNode = targets[randIndex]
	var target = Vector2(targetNode.position.x, targetNode.position.y)
	return target

func take_damage():
	hits -= 1
	print(hits)
	if hits < 1:
		queue_free()

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		print("osu")
		take_damage()

func _input(event):
	if event.is_action_pressed("ui_up"):
		#target = get_global_mouse_position()
		target = get_target()
		print(target)
		print(position.direction_to(target).x)
		if position.direction_to(target).x < 0:
			get_node("AnimatedSprite").set_flip_v(true)
		else:
			get_node("AnimatedSprite").set_flip_v(false)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	look_at(target)
	#if position.distance_to(target) > 5:
		#velocity = move_and_slide(velocity)
	var collision = move_and_collide(velocity*delta)
	if collision:
		print(collision.get_collider())
		collision.get_collider().get_parent().queue_free()
		
