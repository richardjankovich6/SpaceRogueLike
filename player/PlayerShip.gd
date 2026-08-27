extends RigidBody3D

var pending_impules : Vector3 = Vector3.ZERO

var acceleration_rate : Vector3 = Vector3(1.0, 0.5, 0.4)

var screen_x_rotate : float = 0.0
var screen_y_rotate : float = 0.0
var LOOKAROUND_SPEED = 0.02

func _enter_tree() -> void:
	gravity_scale = 0
	#print("set gravity scale to: ", gravity_scale)

#func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	#pass
	#if Input.is_action_pressed("move_right"):
		#pending_impules.x +=1
	#if Input.is_action_pressed("move_left"):
		#pending_impules.x -=1
	#if Input.is_action_pressed("move_back"):
		#pending_impules.z +=1
	#if Input.is_action_pressed("move_forward"):
		#pending_impules.z -=1
	#if Input.is_action_pressed("move_up"):
		#pending_impules.y +=1
	#if Input.is_action_pressed("move_down"):
		#pending_impules.y -=1
	#constant_force += pending_impules
	#pending_impules = Vector3.ZERO
	
	
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion and event.button_mask & 1:
		screen_x_rotate += event.relative.x * LOOKAROUND_SPEED
		screen_y_rotate += event.relative.y * LOOKAROUND_SPEED
		
		transform.basis = Basis();
		rotate_object_local(Vector3(0, -1, 0), screen_x_rotate)
		rotate_object_local(Vector3(0, 0, -1), screen_y_rotate)
		
		
	if event.is_action("break"):
		
		var current_velocity = transform.basis * linear_velocity
		
		if abs(linear_velocity.x) >= acceleration_rate.x:
			pending_impules.x = -1 if _isPositive(current_velocity.x) else 1
		else:
			linear_velocity.x = 0
			pending_impules.x = 0
			
		if abs(linear_velocity.y) >= acceleration_rate.y:
			pending_impules.y = -1 if _isPositive(current_velocity.y) else 1
		else:
			linear_velocity.y = 0
			pending_impules.y = 0
			
		if abs(linear_velocity.z) >= acceleration_rate.z:
			pending_impules.z = -1 if _isPositive(current_velocity.z) else 1
		else:
			linear_velocity.z = 0
			pending_impules.z = 0
			
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
		
	#pending_impules = pending_impules * acceleration_rate
	#pending_impules = transform.basis * pending_impules
	pending_impules = transform.basis * (pending_impules * acceleration_rate)
	
	linear_velocity += pending_impules

	pending_impules = Vector3.ZERO
	
func _isPositive(value: Variant) -> bool:
	return value >= 0
