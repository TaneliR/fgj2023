extends Camera2D	

# This affects how the camera zooms out based on the distance
# of the two most distant nodes on screen. Default tested value 5000
export var zoom_multiplier = 1

export var shake_intensity = 0.5
export var shake_duration = 0.3

export var zoom_speed = 2
var smooth_zoom = 1
var target_zoom = 1

var shake_timer = 0
var centerPoint
var c
var vel = Vector3()
var speed = 2

func start_shake():
	shake_timer = shake_duration

func _process(delta):
	smooth_zoom = lerp(smooth_zoom, target_zoom, zoom_speed * delta)
	if smooth_zoom < (target_zoom - 0.1):
		set_zoom(Vector2(smooth_zoom, smooth_zoom))
	elif !get_node("Area2D").is_monitoring():
		get_node("Area2D").set_monitoring(true)
	
	call_deferred("check_collision")
	
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

	elif centerPoint:
		position = lerp(position, centerPoint, 0.9)
	else: 
		position = Vector2(0, 0)

func _on_ready():
	smoothing_enabled = true

func _on_CameraNode_average_signal(average_signal):
	centerPoint = average_signal		# set camera pos 

func check_collision():
	if (get_node("Area2D").is_monitoring()):
		if get_node("Area2D").get_overlapping_bodies().size():
			get_node("Area2D").set_monitoring(false)
			set_scale(get_scale() * 1.20)	
			target_zoom = target_zoom * 1.20
		
