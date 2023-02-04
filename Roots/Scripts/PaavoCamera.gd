extends Camera2D	

# This affects how the camera zooms out based on the distance
# of the two most distant nodes on screen. Default tested value 5000
export var zoom_multiplier = 5000

export var shake_intensity = 0.5
export var shake_duration = 0.3

var shake_timer = 0

func start_shake():
	shake_timer = shake_duration

func _process(delta):
	if shake_timer > 0:
		# Decrement the shake timer
		shake_timer -= delta

		# Set a random offset for the camera position
		position = Vector2(
			rand_range(-shake_intensity, shake_intensity),
			rand_range(-shake_intensity, shake_intensity)
		)

		# Fade out the shake intensity over time
		shake_intensity *= (1 - delta / shake_duration)
		
	else:
		position = Vector2(0, 0)

func _on_ready():
	smoothing_enabled = true

func _on_CameraNode_average_signal(average_signal): 
	position = average_signal		# set camera pos 

func _on_CameraNode_max_distance(max_distance):	
	set_zoom(Vector2(zoom_multiplier / max_distance, zoom_multiplier / max_distance))
