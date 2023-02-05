extends Node2D

export var y_descent = 1000
export var movement_speed = 2500

onready var l_spawn = get_node("L_Spawner")
onready var r_spawn = get_node("R_Spawner")
onready var randArray = [l_spawn, r_spawn]
onready var timer1 = Timer.new()
onready var timer2 = Timer.new()



var upright_position = Vector2(0, 500) #1000 on ylin mahd. positio
var downright_position = Vector2(0, y_descent)
var going_down = true

var journey_time = upright_position.distance_to(downright_position) / movement_speed

var rng = RandomNumberGenerator.new()
var molePrefab = preload("res://Prefabs/mole.tscn")

func _ready():
	rng.randomize()
	print(l_spawn)
	print(r_spawn)
	timer1.connect("timeout", self, "_on_timer1_timeout")
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer1)
	add_child(timer2)
	timer1.start(2)

func _on_timer1_timeout():
	timer2.start(1)

func _on_timer2_timeout():
	randomize_and_spawn()
	timer2.start(1)

func _process(delta):
	if going_down: 
		position = position.move_toward(downright_position, delta * movement_speed)
	else:
		position = position.move_toward(upright_position, delta * movement_speed)
	
	if position >= downright_position + Vector2(0, -5):
		going_down = false
	elif position <= upright_position + Vector2(0, 5):
		going_down = true
		

func _input(event):
	if event.is_action_pressed("ui_up"):
		randomize_and_spawn()

func randomize_and_spawn():
	var randIndex = rng.randi_range(0, randArray.size()-1)
	var targetNode = randArray[randIndex]
	var newMole = molePrefab.instance()
	print(randArray)
	print(newMole)
	newMole.global_position = targetNode.global_position
	get_node("/root/Node2D").add_child(newMole)
	
