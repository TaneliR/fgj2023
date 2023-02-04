extends KinematicBody2D

export (int) var speed = 200
var hits = 10

onready var target = position
var velocity = Vector2()

func _ready():
	add_to_group("moles")

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
		target = get_global_mouse_position()
		print(target)
		print(position.direction_to(target).x)
		if position.direction_to(target).x < 0:
			get_node("AnimatedSprite").set_flip_v(true)
		else:
			get_node("AnimatedSprite").set_flip_v(false)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	
