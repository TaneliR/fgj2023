extends AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	stop()
	play_music()

func play_music():
	play()

func stop_music():
	stop()
