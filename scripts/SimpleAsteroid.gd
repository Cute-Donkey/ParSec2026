extends RigidBody3D

@export var health: float = 100.0

func _ready():
	# Set up physics properties
	gravity_scale = 0.0
	linear_damp = 0.01
	angular_damp = 0.01
	
	# Add some random rotation for visual effect
	angular_velocity = Vector3(
		randf_range(-1, 1),
		randf_range(-1, 1),
		randf_range(-1, 1)
	)
	
	print("SimpleAsteroid initialized!")

func take_damage(damage: float):
	health -= damage
	print("Asteroid took ", damage, " damage. Health: ", health)
	
	if health <= 0:
		destroy_asteroid()

func destroy_asteroid():
	print("Asteroid destroyed!")
	
	# Create simple explosion effect
	var light = OmniLight3D.new()
	light.light_color = Color.ORANGE
	light.light_energy = 8.0
	light.shadow_enabled = false
	light.position = global_position
	
	get_tree().root.add_child(light)
	
	# Remove light after explosion
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(func(): light.queue_free())
	
	# Remove asteroid
	queue_free()
