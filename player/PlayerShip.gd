extends RigidBody3D

var pending_impules : Vector3 = Vector3.ZERO

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
	#print("processing input")
	if event.is_action("move_right"):
		pending_impules.x +=1
	if event.is_action("move_left"):
		pending_impules.x -=1
	if event.is_action("move_back"):
		pending_impules.z +=1
	if event.is_action("move_forward"):
		pending_impules.z -=1
	if event.is_action("move_up"):
		pending_impules.y +=1
	if event.is_action("move_down"):
		pending_impules.y -=1
	#add_constant_central_force(pending_impules)
	#add_force(pending_impules)
	#add_constant_central_force(pending_impules)
	constant_force += pending_impules
	pending_impules = Vector3.ZERO
