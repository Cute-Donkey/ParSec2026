extends Node

func _ready():
	print("🎮 Testing input configuration...")
	
	# Test essential input actions
	var required_actions = [
		"thrust_forward",
		"thrust_backward", 
		"roll_left",
		"roll_right",
		"pitch_up",
		"pitch_down",
		"yaw_left",
		"yaw_right",
		"fire_weapon"
	]
	
	var missing_actions = []
	
	for action in required_actions:
		if not InputMap.has_action(action):
			missing_actions.append(action)
		else:
			var events = InputMap.action_get_events(action)
			if events.is_empty():
				missing_actions.append(action + " (no events)")
	
	if missing_actions.is_empty():
		print("✅ All required input actions found")
	else:
		print("❌ Missing input actions:")
		for action in missing_actions:
			print("  - ", action)
		get_tree().quit(1)
	
	# Test specific input mappings
	print("🔍 Checking specific input mappings...")
	
	# Check WASD for pitch/yaw
	var pitch_up_events = InputMap.action_get_events("pitch_up")
	var has_w = false
	for event in pitch_up_events:
		if event is InputEventKey and event.keycode == KEY_W:
			has_w = true
			break
	
	if has_w:
		print("✅ W key mapped to pitch_up")
	else:
		print("⚠️ W key not found in pitch_up")
	
	# Check Space for thrust
	var thrust_events = InputMap.action_get_events("thrust_forward")
	var has_space = false
	for event in thrust_events:
		if event is InputEventKey and event.keycode == KEY_SPACE:
			has_space = true
			break
	
	if has_space:
		print("✅ Space key mapped to thrust_forward")
	else:
		print("⚠️ Space key not found in thrust_forward")
	
	print("✅ Input configuration test completed")
	get_tree().quit(0)
