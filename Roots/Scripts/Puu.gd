extends Node2D

export var growth_timer = 5
onready var timer = Timer.new()
onready var puu1 = get_node("Puu1")
onready var puu2 = get_node("Puu2")
onready var puu3 = get_node("Puu3")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)
	timer.start(growth_timer)

func _on_Timer_timeout():
	if (puu2.is_visible()):
		puu2.set_visible(false)
		puu3.set_visible(true)
		
	if (puu1.is_visible()):
		puu1.set_visible(false)
		puu2.set_visible(true)
		timer.start(growth_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
