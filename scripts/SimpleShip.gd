extends RigidBody3D

@export var max_thrust: float = 1000.0
@export var max_torque: float = 500.0

var thrust_force: Vector3 = Vector3.ZERO
var torque_force: Vector3 = Vector3.ZERO

func _ready():
	# Disable gravity for space physics
	gravity_scale = 0.0
	linear_damp = 0.01
	angular_damp = 0.01
	
	print("SimpleShip initialized!")

func _physics_process(delta):
	# Handle input
	var input_vector = Vector3.ZERO
	var torque_vector = Vector3.ZERO
	
	# Thrust controls
	if Input.is_action_pressed("thrust_forward"):
		input_vector += -transform.basis.z
	if Input.is_action_pressed("thrust_backward"):
		input_vector += transform.basis.z
	
	# Rotation controls
	if Input.is_action_pressed("pitch_up"):
		torque_vector += transform.basis.x
	if Input.is_action_pressed("pitch_down"):
		torque_vector += -transform.basis.x
	if Input.is_action_pressed("roll_left"):
		torque_vector += -transform.basis.z
	if Input.is_action_pressed("roll_right"):
		torque_vector += transform.basis.z
	if Input.is_action_pressed("yaw_left"):
		torque_vector += transform.basis.y
	if Input.is_action_pressed("yaw_right"):
		torque_vector += -transform.basis.y
	
	# Apply forces
	if input_vector != Vector3.ZERO:
		apply_central_force(input_vector.normalized() * max_thrust)
	
	if torque_vector != Vector3.ZERO:
		apply_torque(torque_vector.normalized() * max_torque)
	
	# Apply persistent forces
	if thrust_force != Vector3.ZERO:
		apply_central_force(thrust_force)
	
	if torque_force != Vector3.ZERO:
		apply_torque(torque_force)

func apply_thrust(direction: Vector3, thrust_amount: float):
	thrust_force = direction.normalized() * thrust_amount * max_thrust

func apply_custom_torque(direction: Vector3, torque_amount: float):
	torque_force = direction.normalized() * torque_amount * max_torque

func stop_thrust():
	thrust_force = Vector3.ZERO

func stop_torque():
	torque_force = Vector3.ZERO
