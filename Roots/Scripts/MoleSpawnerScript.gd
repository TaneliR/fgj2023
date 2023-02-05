extends Node2D

export var y_descent = 1000
export var movement_speed = 2500

onready var l_spawn = get_node("L_Spawner")
onready var r_spawn = get_node("R_Spawner")

var upright_position = Vector2(0, 0)
var downright_position = Vector2(0, y_descent)
var going_down = true

var journey_time = upright_position.distance_to(downright_position) / movement_speed

var rng = RandomNumberGenerator.new()
var molePrefab = preload("res://Prefabs/mole.tscn")

func _process(delta):
	if going_down: 
		position = position.move_toward(downright_position, delta * movement_speed)
	else:
		position = position.move_toward(upright_position, delta * movement_speed)
	
	if position >= downright_position + Vector2(0, -5):
		going_down = false
		randomize_and_spawn()
	elif position <= upright_position + Vector2(0, 5):
		going_down = true
		
func randomize_and_spawn():
	rng.randomize()
	var randArray = [l_spawn, r_spawn]
	var randIndex = rng.randi_range(0, randArray.size()-1)
	var targetNode = randArray[randIndex]
	
	var newMole = molePrefab.instance()
	newMole.position = targetNode.position
	add_child(newMole)
	
