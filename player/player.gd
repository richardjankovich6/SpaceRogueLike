extends Node3D

@onready var ship : RigidBody3D = $PlayerShip
@onready var camera : Node3D = $Camera
var using_controller : bool = false
#var using_controller : bool = true

#var JOY_ROTATION_SENSITIVITY: float = 150
var joy_rotation_sensitivity: float = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ship = $PlayerShip
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_handleRotationInput()
	_handleImpulseInput()
	#transform.translated(ship.get_position())
	#ship.set_position(Vector3.ZERO)

func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#using_controller = false
		
	
	if event.is_action_pressed("boost"):
		ship.activate_boost()
		camera.activate_boost()
	if event.is_action_released("boost"):
		ship.deactivate_boost()
		camera.deactivate_boost()
	

func _handleImpulseInput() -> void:
	var pending_impulse: Vector3 = Vector3.ZERO

	if Input.is_action_pressed("quit"):
		get_tree().quit()

	if Input.is_action_pressed("break"):
		ship.applyBreak()
	else:
		if Input.is_action_pressed("move_right"):
			pending_impulse.z += 1
		if Input.is_action_pressed("move_left"):
			pending_impulse.z -= 1
		if Input.is_action_pressed("move_backward"):
			pending_impulse.x -= 1
		if Input.is_action_pressed("move_forward"):
			pending_impulse.x += 1
		if Input.is_action_pressed("move_up"):
			pending_impulse.y += 1
		if Input.is_action_pressed("move_down"):
			pending_impulse.y -= 1
		ship.set_pending_impulse(pending_impulse)
	

func _handleRotationInput() -> void:

	var yaw_delta: float
	var pitch_delta: float
	var roll_delta: float

	if using_controller:
		#Input.get_vector("roll_left", "roll_right", "yaw_left", "yaw_right", "pitch_down", "pitch_up")
		#var rot = Input.get_vector("roll_left", "roll_right", "pitch_down", "pitch_up") * 100
		#var rot = Input.get_vector("pitch_up",  "pitch_down", "roll_right", "roll_left") * 100
		# TODO
		# magic number makes it playable, remove later
		#var rot = Input.get_vector("pitch_up",  "pitch_down", "yaw_left", "yaw_right") * 150
		#print(rot)
		#roll_delta = Input.get_axis("roll_left", "roll_right") * joy_rotation_sensitivity
		roll_delta = 0
		yaw_delta = Input.get_axis("yaw_left", "yaw_right") * joy_rotation_sensitivity
		pitch_delta = Input.get_axis("pitch_up",  "pitch_down") * joy_rotation_sensitivity
		
	else:
		roll_delta = 0
		yaw_delta = 0
		pitch_delta = 0
		
		var mouse_velocity = Input.get_last_mouse_screen_velocity()
		yaw_delta = mouse_velocity.x
		pitch_delta = mouse_velocity.y
		
	# rotation has x=roll, y=yaw, z=pitch
	ship.set_pending_rotation(Vector3(roll_delta, yaw_delta, pitch_delta))
