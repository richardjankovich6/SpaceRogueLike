extends RigidBody3D

#var using_controller: bool = true
var using_controller: bool = false

var acceleration_rate : Vector3 = Vector3(15.0, 8, 8)

var screen_x_rotate : float = 0.0
var screen_y_rotate : float = 0.0

var rotation_speed = 0.005

func _enter_tree() -> void:
	gravity_scale = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#Input.joy_connection_changed()
	#Input.is_joy_known()


func _process(delta: float) -> void:
	
	_handleRotationInput(delta)
	
	_handleVelocityInput(delta)
	
	var parent: Node3D = get_parent_node_3d()
	if parent != null:
		parent.transform = parent.transform.translated(linear_velocity * delta)

func _input(event: InputEvent) -> void:
	return
	
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

func _handleVelocityInput(delta: float) -> void:
	var pending_impules: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_pressed("break"):
		var current_velocity: Vector3 = transform.basis * linear_velocity
		for i in range (3):
			if abs(linear_velocity[i]) >= acceleration_rate[i]:
				pending_impules[i] = -1 if current_velocity[i] >= 0 else 1
			else:
				linear_velocity[i] = 0
				pending_impules[i] = 0
			
	else:
		if Input.is_action_pressed("move_right"):
			pending_impules.z += 1
		elif Input.is_action_pressed("move_left"):
			pending_impules.z -= 1
		elif Input.is_action_pressed("move_backward"):
			pending_impules.x -= 1
		elif Input.is_action_pressed("move_forward"):
			pending_impules.x += 1
		elif Input.is_action_pressed("move_up"):
			pending_impules.y += 1
		elif Input.is_action_pressed("move_down"):
			pending_impules.y -= 1
		
	pending_impules = transform.basis * (pending_impules * acceleration_rate)
	linear_velocity += pending_impules * delta

func _handleRotationInput(delta: float) -> void:
	
	var yaw_delta: float
	var pitch_delta: float
	var roll_delta: float = 0
	
	if using_controller:
		yaw_delta = 0
		pitch_delta = 0
		
	else:
		var mouse_velocity = Input.get_last_mouse_screen_velocity()
		yaw_delta = mouse_velocity.x
		pitch_delta = mouse_velocity.y
	
	# rotation has z=pitch, y=yaw, x=roll
	
	if abs(roll_delta) > 0: # adjust roll
		rotation.x -= roll_delta * rotation_speed * delta
		rotation.x = clamp(rotation.x, -360, 360)
	if abs(yaw_delta) > 0: # adjust yaw
		rotation.y -= yaw_delta * rotation_speed * delta
		rotation.y = clamp(rotation.y, -360, 360)
	if abs(pitch_delta) > 0: # adjust pitch
		rotation.z -= pitch_delta * rotation_speed * delta / 10
		rotation.z = clamp(rotation.z, -360, 360)
