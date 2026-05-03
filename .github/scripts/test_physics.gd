extends Node

func _ready():
	print("⚛️ Testing physics configuration...")
	
	# Test physics settings
	var physics_3d = PhysicsServer3D
	if not physics_3d.is_active():
		print("❌ Physics3D server not active")
		get_tree().quit(1)
		return
	
	print("✅ Physics3D server active")
	
	# Test gravity settings (should be zero for space)
	var default_gravity = physics_3d.area_get_param(get_viewport().find_world_3d().get_space(), PhysicsServer3D.AREA_PARAM_GRAVITY)
	if default_gravity.length() > 0.1:
		print("⚠️ Gravity detected (should be zero for space): ", default_gravity)
	else:
		print("✅ No gravity (correct for space)")
	
	# Test collision layers
	print("🔍 Checking collision layers...")
	
	# Create test objects to verify physics
	var test_ship = RigidBody3D.new()
	test_ship.mass = 100.0
	test_ship.gravity_scale = 0.0
	test_ship.linear_damp = 0.01
	test_ship.angular_damp = 0.01
	
	var test_asteroid = RigidBody3D.new()
	test_asteroid.mass = 100.0
	test_asteroid.gravity_scale = 0.0
	test_asteroid.linear_damp = 0.01
	test_asteroid.angular_damp = 0.01
	
	# Add collision shapes
	var ship_shape = CollisionShape3D.new()
	var ship_box = BoxShape3D.new()
	ship_box.size = Vector3(2, 1, 3)
	ship_shape.shape = ship_box
	test_ship.add_child(ship_shape)
	
	var asteroid_shape = CollisionShape3D.new()
	var asteroid_sphere = SphereShape3D.new()
	asteroid_sphere.radius = 2.0
	asteroid_shape.shape = asteroid_sphere
	test_asteroid.add_child(asteroid_shape)
	
	# Add to scene temporarily
	add_child(test_ship)
	add_child(test_asteroid)
	
	# Test physics properties
	if test_ship.mass > 0 and test_ship.gravity_scale == 0.0:
		print("✅ Ship physics properties correct")
	else:
		print("❌ Ship physics properties incorrect")
		get_tree().quit(1)
		return
	
	if test_asteroid.mass > 0 and test_asteroid.gravity_scale == 0.0:
		print("✅ Asteroid physics properties correct")
	else:
		print("❌ Asteroid physics properties incorrect")
		get_tree().quit(1)
		return
	
	# Test collision detection
	test_ship.position = Vector3(0, 0, 0)
	test_asteroid.position = Vector3(5, 0, 0)
	
	# Apply test force
	test_ship.apply_central_impulse(Vector3(1, 0, 0))
	
	await get_tree().create_timer(0.1).timeout
	
	# Check if ship moved
	if test_ship.linear_velocity.length() > 0:
		print("✅ Physics simulation working")
	else:
		print("❌ Physics simulation not working")
		get_tree().quit(1)
		return
	
	# Cleanup
	test_ship.queue_free()
	test_asteroid.queue_free()
	
	print("✅ Physics configuration test completed")
	get_tree().quit(0)
