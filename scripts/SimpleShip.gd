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
	# Apply thrust force
	if thrust_force != Vector3.ZERO:
		apply_central_force(thrust_force)
	
	# Apply torque for rotation
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
