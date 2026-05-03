extends Node3D

var camera: Camera3D
var ship: RigidBody3D
var rotation_speed: float = 1.0
var thrust_speed: float = 10.0

func _ready():
	camera = $Ship/Camera3D
	ship = $Ship
	
	# Position asteroid in front of camera
	var asteroid = $Asteroid
	var camera_position = camera.global_position
	var camera_forward = -camera.global_transform.basis.z
	var distance = 10.0
	asteroid.global_position = camera_position + camera_forward * distance
	
	print("TestControls initialized!")

func _process(delta):
	# Ship rotation controls
	var rotation_input = Vector3.ZERO
	
	if Input.is_action_pressed("ui_left"):
		rotation_input.y += rotation_speed * delta
	if Input.is_action_pressed("ui_right"):
		rotation_input.y -= rotation_speed * delta
	if Input.is_action_pressed("ui_up"):
		rotation_input.x += rotation_speed * delta
	if Input.is_action_pressed("ui_down"):
		rotation_input.x -= rotation_speed * delta
	
	if rotation_input != Vector3.ZERO:
		# Apply torque to RigidBody3D for rotation
		ship.apply_torque(rotation_input * 100.0)
	
	# Ship movement controls
	var thrust = Vector3.ZERO
	
	if Input.is_action_pressed("ui_accept"):  # Space
		thrust = -ship.global_transform.basis.z * thrust_speed
	elif Input.is_action_pressed("ui_select"):  # Shift+Space
		thrust = ship.global_transform.basis.z * thrust_speed
	
	if thrust != Vector3.ZERO:
		ship.apply_central_force(thrust)
