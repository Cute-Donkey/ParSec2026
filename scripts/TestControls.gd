extends Node3D

var camera: Camera3D
var ship: RigidBody3D
var asteroid: RigidBody3D
var sun: DirectionalLight3D
var sun_mesh: MeshInstance3D
var rotation_speed: float = 1.0
var thrust_speed: float = 10.0

# HUD display variables
var hud_label: Label
var help_dialog: Control
var help_visible: bool = false

func _ready():
	camera = $Ship/Camera3D
	ship = $Ship
	asteroid = $Asteroid
	sun = $DirectionalLight3D
	sun_mesh = null  # Will be set in setup_sun()
	
	# Position asteroid in front of camera
	var camera_position = camera.global_position
	var camera_forward = -camera.global_transform.basis.z
	var distance = 75.0
	asteroid.global_position = camera_position + camera_forward * distance
	
	# Create visible sun
	setup_sun()
	
	# Create HUD
	setup_hud()
	
	print("TestControls initialized!")

func setup_sun():
	# Create a visible sun object at the light source position
	var sun_mesh = MeshInstance3D.new()
	add_child(sun_mesh)
	
	# Create sphere mesh for sun (realistic size)
	var sphere = SphereMesh.new()
	sphere.radius = 50.0  # Much larger - visible from far away
	sphere.height = 100.0
	sun_mesh.mesh = sphere
	
	# Create glowing material for sun
	var sun_material = StandardMaterial3D.new()
	sun_material.albedo_color = Color(1.0, 0.9, 0.3, 1.0)  # Yellow color
	sun_material.emission = Color(1.0, 0.9, 0.3, 1.0)  # Glowing effect
	sun_material.emission_energy = 10.0  # Much brighter
	sun_material.disable_fog = true  # Always visible
	sun_mesh.material_override = sun_material
	
	# Position sun closer but still far away for visibility
	var sun_direction = -sun.global_transform.basis.z  # Same direction as light
	sun_mesh.global_position = sun.global_position + sun_direction * 1000.0  # 1km away
	sun_mesh.name = "SunMesh"
	
	# Store reference for distance calculation
	self.sun_mesh = sun_mesh

func setup_hud():
	# Create a Control node for HUD
	var hud_control = Control.new()
	add_child(hud_control)
	
	# Set anchors to top-left
	hud_control.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT)
	
	# Create Label for HUD display
	hud_label = Label.new()
	hud_control.add_child(hud_label)
	hud_label.position = Vector2(10, 10)
	hud_label.add_theme_font_size_override("font_size", 16)
	hud_label.add_theme_color_override("font_color", Color.WHITE)
	
	# Create modal help dialog (initially hidden)
	help_dialog = Control.new()
	add_child(help_dialog)
	help_dialog.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	help_dialog.visible = false
	
	# Create semi-transparent background
	var background = ColorRect.new()
	help_dialog.add_child(background)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.color = Color(0, 0, 0, 0.8)  # Dark semi-transparent
	
	# Create help label
	var help_label = Label.new()
	help_dialog.add_child(help_label)
	help_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	help_label.add_theme_font_size_override("font_size", 16)
	help_label.add_theme_color_override("font_color", Color.WHITE)
	help_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	help_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Store reference for help toggle
	self.help_dialog = help_dialog

func _input(event):
	# Toggle help with F1 key (only on key press, not hold)
	if event is InputEventKey and event.pressed and event.keycode == KEY_F1:
		toggle_help()
	
	# Quit game with ESC key
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().quit()

func _process(delta):
	# Emergency stop with S key
	if Input.is_key_pressed(KEY_S):  # S key
		emergency_stop()
	
	# Update HUD display
	update_hud()
	
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

func emergency_stop():
	# Stop all linear velocity
	ship.linear_velocity = Vector3.ZERO
	
	# Stop all angular velocity (rotation around all axes)
	ship.angular_velocity = Vector3.ZERO
	
	# Also clear any accumulated forces and torques
	ship.apply_central_impulse(-ship.linear_velocity)
	ship.apply_torque_impulse(-ship.angular_velocity)
	
	print("Emergency stop activated - All ship movement stopped!")

func toggle_help():
	help_visible = !help_visible
	help_dialog.visible = help_visible
	
	if help_visible:
		update_help_display()
		print("Hilfe angezeigt")
	else:
		print("Hilfe versteckt")

func update_help_display():
	if help_dialog == null:
		return
	
	# Get the help label from the dialog
	var help_label = help_dialog.get_child(1)  # Background is child 0, label is child 1
	
	# Format help text with all key bindings
	var help_text = "=== TASTENBELEGUNGEN ===\n\n"
	help_text += "BEWEGUNG:\n"
	help_text += "Pfeil hoch/runter     - Schiff neigen (Pitch)\n"
	help_text += "Pfeil links/rechts   - Schiff drehen (Yaw)\n"
	help_text += "Leertaste            - Vorwärts schubsen\n"
	help_text += "Umschalt+Leertaste   - Rückwärts schubsen\n\n"
	help_text += "SONDERFUNKTIONEN:\n"
	help_text += "S                    - Notstopp (alle Bewegung)\n"
	help_text += "F1                   - Diese Hilfe ein/aus\n"
	help_text += "ESC                  - Spiel beenden\n\n"
	help_text += "ANZEIGE:\n"
	help_text += "HUD links oben zeigt Echtzeitdaten\n"
	help_text += "Geschwindigkeit, Drehraten, Distanzen\n\n"
	help_text += "Drücke F1 um Hilfe zu schließen"
	
	help_label.text = help_text

func update_hud():
	if hud_label == null:
		return
	
	# Get ship velocity
	var velocity = ship.linear_velocity
	var speed = velocity.length()
	
	# Get ship angular velocity (rotation speeds)
	var angular_velocity = ship.angular_velocity
	
	# Calculate distances
	var distance_to_asteroid = ship.global_position.distance_to(asteroid.global_position)
	var distance_to_sun = ship.global_position.distance_to(sun_mesh.global_position) if sun_mesh else 0.0
	
	# Format HUD text
	var hud_text = "=== SCHIFF-DATEN ===\n"
	hud_text += "Geschwindigkeit: %.1f m/s\n" % speed
	hud_text += "Geschw. Vektor: (%.1f, %.1f, %.1f)\n" % [velocity.x, velocity.y, velocity.z]
	hud_text += "\n=== DREHRATEN ===\n"
	hud_text += "X-Achse (Pitch): %.3f rad/s\n" % angular_velocity.x
	hud_text += "Y-Achse (Yaw): %.3f rad/s\n" % angular_velocity.y
	hud_text += "Z-Achse (Roll): %.3f rad/s\n" % angular_velocity.z
	hud_text += "\n=== OBJEKTE ===\n"
	hud_text += "Sonne Distanz: %.1f m\n" % distance_to_sun
	hud_text += "Asteroid Distanz: %.1f m" % distance_to_asteroid
	
	# Add help hint if help is not visible
	if not help_visible:
		hud_text += "\n\n[F1 für Hilfe]"
	
	hud_label.text = hud_text
