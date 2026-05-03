extends Node3D

var camera: Camera3D
var cube: MeshInstance3D
var player: Node3D
var rotation_speed: float = 1.5
var thrust_speed: float = 8.0
var camera_distance: float = 10.0
var camera_height: float = 3.0

func _ready():
	camera = $Camera3D
	cube = $TestCube
	
	# Create player node (spaceship)
	player = Node3D.new()
	player.name = "Player"
	add_child(player)
	
	# Initialize positions
	player.position = Vector3(0, 0, 0)
	cube.position = Vector3(15, 0, 0)  # Cube further in front
	update_camera_position()
	print("TestControls initialized!")

func _physics_process(delta):
	var player_rotated = false
	var player_moved = false
	
	# Player rotation (arrow keys rotate the player)
	if Input.is_action_pressed("ui_left"):
		player.rotate_y(rotation_speed * delta)
		player_rotated = true
	if Input.is_action_pressed("ui_right"):
		player.rotate_y(-rotation_speed * delta)
		player_rotated = true
	if Input.is_action_pressed("ui_up"):
		player.rotate_x(rotation_speed * delta)
		player_rotated = true
	if Input.is_action_pressed("ui_down"):
		player.rotate_x(-rotation_speed * delta)
		player_rotated = true
	
	# Thrust (spacebar moves player forward in their facing direction)
	if Input.is_action_pressed("ui_accept"):  # Spacebar
		var forward = player.global_transform.basis.z  # Use positive Z as forward
		player.position += forward * thrust_speed * delta
		player_moved = true
	
	# Reverse thrust (shift+spacebar moves player backward)
	if Input.is_action_pressed("ui_cancel"):  # Shift+Spacebar
		var forward = player.global_transform.basis.z
		player.position -= forward * thrust_speed * delta
		player_moved = true
	
	if player_rotated or player_moved:
		update_camera_position()

func update_camera_position():
	# Camera follows player with offset behind them
	var behind_offset = -player.global_transform.basis.z * camera_distance
	camera.position = player.position + behind_offset + Vector3(0, camera_height, 0)
	camera.look_at(player.position)
