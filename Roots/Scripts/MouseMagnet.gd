extends KinematicBody2D

var speed = 2000
var velocity = Vector2(speed, 0)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_velocity():
	# Add these actions in Project Settings -> Input Map.
	velocity = Vector2(speed, 0).rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	var dir = get_global_mouse_position() - global_position
	# Don't move if too close to the mouse pointer.
	if dir.length() > 25:
		get_velocity()
		rotation = dir.angle()
		var coll = move_and_collide(velocity * delta, false)
		if coll:
			print("I collided with ", coll.collider.name)
