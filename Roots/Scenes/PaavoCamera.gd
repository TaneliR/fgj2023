extends Camera2D

func _on_CameraNode_average_signal(average_signal):
	print("Received average position:", average_signal)
