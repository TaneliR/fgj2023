extends Area2D


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#
#func get_velocity():
#	# Add these actions in Project Settings -> Input Map.
#	velocity = Vector2(speed, 0).rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()

