extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_global_mouse_position()

	if (get_overlapping_bodies().size() > 0):
		for body in get_overlapping_bodies():
			if ("moleBody" in body.name):
				body.queue_free()
