
#res://ship/ship.gd

#class_name Ship

extends Node
#class Player:
	
	
	
	
	#"res://ship/ship.gd"
	#include("res://ship/ship.gd")
	
	
var ship : RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ship = $PlayerShip
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handleRotationInput()
	_handleImpulseInput()
	#transform = transform.translated(ship.linear_velocity * delta)

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

	#if using_controller:
	if false:
		roll_delta = 0
		yaw_delta = 0
		pitch_delta = 0
		
	else:
		roll_delta = 0
		yaw_delta = 0
		pitch_delta = 0
		
		var mouse_velocity = Input.get_last_mouse_screen_velocity()
		yaw_delta = mouse_velocity.x
		pitch_delta = mouse_velocity.y
		
	# rotation has x=roll, y=yaw, z=pitch
	ship.set_pending_rotation(Vector3(roll_delta, yaw_delta, pitch_delta))
