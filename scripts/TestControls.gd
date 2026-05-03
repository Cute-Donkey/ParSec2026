extends Node3D

var camera: Camera3D
var ship: RigidBody3D
var rotation_speed: float = 0.5

func _ready():
	camera = $Ship/Camera3D
	ship = $Ship
	print("TestControls initialized!")

func _process(delta):
	# Camera rotation around ship
	var rotation_amount = 0.0
	if Input.is_action_pressed("ui_left"):
		rotation_amount -= rotation_speed
	if Input.is_action_pressed("ui_right"):
		rotation_amount += rotation_speed
	
	if rotation_amount != 0.0:
		# Rotate camera around the ship
		var current_angle = atan2(camera.position.z, camera.position.x)
		var new_angle = current_angle + rotation_amount * delta
		var distance = Vector2(camera.position.x, camera.position.z).length()
		
		camera.position.x = cos(new_angle) * distance
		camera.position.z = sin(new_angle) * distance
		camera.look_at(ship.global_position)
	
	# Zoom in/out
	if Input.is_action_pressed("ui_up"):
		camera.position = camera.position.move_toward(ship.global_position, delta * 5)
	if Input.is_action_pressed("ui_down"):
		camera.position = camera.position.move_toward(ship.global_position, -delta * 5)
		camera.look_at(ship.global_position)
