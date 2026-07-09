extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var speed : float = 14
@export var fall_acceleration : float = 0

var target_velocity : Vector3 = Vector3.ZERO



func _physics_process(delta: float) -> void:
	var direction : Vector3 = Vector3.ZERO
	
	if Input.is_action_just_pressed("move_right"):
		direction.x +=1
	if Input.is_action_just_pressed("move_left"):
		direction.x -=1
	if Input.is_action_just_pressed("move_back"):
		direction.z +=1
	if Input.is_action_just_pressed("move_forward"):
		direction.z -=1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.Basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	velocity = target_velocity
	
	move_and_slide()
	
	
	
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	#move_and_slide()
