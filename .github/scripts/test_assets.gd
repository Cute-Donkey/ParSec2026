extends Node

func _ready():
	print("🎨 Testing asset configuration...")
	
	# Test essential assets
	var required_assets = [
		"res://assets/environments/default_env.tres",
		"res://scenes/prototypes/HeadlessPrototype.tscn",
		"res://scenes/game/Ship.tscn",
		"res://scenes/game/Asteroid.tscn"
	]
	
	var missing_assets = []
	
	for asset_path in required_assets:
		if not ResourceLoader.exists(asset_path):
			missing_assets.append(asset_path)
		else:
			print("✅ Found: ", asset_path)
	
	if missing_assets.size() > 0:
		print("❌ Missing assets:")
		for asset in missing_assets:
			print("  - ", asset)
		get_tree().quit(1)
		return
	
	# Test environment loading
	print("🌌 Testing environment...")
	var env = load("res://assets/environments/default_env.tres")
	if env is Environment:
		print("✅ Environment loaded successfully")
	else:
		print("❌ Environment loading failed")
		get_tree().quit(1)
		return
	
	# Test scene loading
	print("🎬 Testing scene loading...")
	var scenes_to_test = [
		"res://scenes/prototypes/HeadlessPrototype.tscn",
		"res://scenes/game/Ship.tscn",
		"res://scenes/game/Asteroid.tscn"
	]
	
	for scene_path in scenes_to_test:
		var scene_resource = load(scene_path)
		if scene_resource is PackedScene:
			print("✅ Scene loaded: ", scene_path)
			
			# Test scene instantiation
			var instance = scene_resource.instantiate()
			if instance:
				print("✅ Scene instantiated: ", scene_path)
				instance.queue_free()
			else:
				print("❌ Scene instantiation failed: ", scene_path)
				get_tree().quit(1)
				return
		else:
			print("❌ Scene loading failed: ", scene_path)
			get_tree().quit(1)
			return
	
	# Test script loading
	print("📝 Testing script loading...")
	var scripts_to_test = [
		"res://scripts/SimpleShip.gd",
		"res://scripts/SimpleAsteroid.gd"
	]
	
	for script_path in scripts_to_test:
		if ResourceLoader.exists(script_path):
			print("✅ Script found: ", script_path)
		else:
			print("⚠️ Script not found: ", script_path)
	
	print("✅ Asset configuration test completed")
	get_tree().quit(0)
