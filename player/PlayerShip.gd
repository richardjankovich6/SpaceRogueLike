extends RigidBody3D

#var pending_impules : Vector3 = Vector3.ZERO

#var acceleration_rate : Vector3 = Vector3(1.0, 0.5, 0.4)
var acceleration_rate : Vector3 = Vector3(10.0, 5, 4)

var screen_x_rotate : float = 0.0
var screen_y_rotate : float = 0.0

var rotation_speed = 0.02

func _enter_tree() -> void:
	gravity_scale = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	
	_handleMouseInput(delta)
	
	var parent: Node3D = get_parent_node_3d()
	if parent != null:
		parent.transform = parent.transform.translated(linear_velocity * delta)



func _input(event: InputEvent) -> void:
	
	var pending_impules: Vector3 = Vector3.ZERO
	
	if event.is_action("quit"):
		get_tree().quit()
		
	if event.is_action("break"):
		var current_velocity: Vector3 = transform.basis * linear_velocity
		for i in range (3):
			if abs(linear_velocity[i]) >= acceleration_rate[i]:
				pending_impules[i] = -1 if current_velocity[i] >= 0 else 1
			else:
				linear_velocity[i] = 0
				pending_impules[i] = 0
			
	else:
		if event.is_action("move_right"):
			pending_impules.z += 1
		elif event.is_action("move_left"):
			pending_impules.z -= 1
		elif event.is_action("move_backward"):
			pending_impules.x -= 1
		elif event.is_action("move_forward"):
			pending_impules.x += 1
		elif event.is_action("move_up"):
			pending_impules.y += 1
		elif event.is_action("move_down"):
			pending_impules.y -= 1
		
	pending_impules = transform.basis * (pending_impules * acceleration_rate)
	linear_velocity += pending_impules

func _handleMouseInput(delta: float) -> void:
	var mouse_velocity = Input.get_last_mouse_screen_velocity()
	#var mouse_velocity = Input.get_last_mouse_velocity()
	
	var dx = mouse_velocity.x
	var dy = mouse_velocity.y

	if abs(dx) > 0:
		rotation.z -= dx * rotation_speed * delta / 10
		rotation.z = clamp(rotation.z, -360, 360)

	if abs(dy) > 0:
		rotation.y += dy * rotation_speed * delta
		rotation.y = clamp(rotation.y, -360, 360)
	rotation.x = 0
	
	
#func _handleFlightInput(delta: float) -> void:
	#Input.action_press("break")
	
	#Input.
