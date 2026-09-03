
extends RigidBody3D
#class Ship:
	
	
	
var pending_rotation : Vector3 = Vector3.ZERO
func set_pending_rotation(InRotation: Vector3) -> void:
	pending_rotation = InRotation
func get_pending_rotation() -> Vector3:
	return pending_rotation
	
var pending_impulse : Vector3 = Vector3.ZERO
func set_pending_impulse(InImpulse: Vector3) -> void:
	pending_impulse = InImpulse
func get_pending_impulse() -> Vector3:
	return pending_impulse

var acceleration_rate : Vector3 = Vector3(15.0, 8, 8)
var rotation_rate : Vector3 = Vector3(0.001, 0.005, 0.008)
# rotation has x=roll, y=yaw, z=pitch


var parent:Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	parent = get_parent_node_3d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	_handlePendingRotation(delta)
	_handlePendingImpulse(delta)
	
	
	if parent != null:
		parent.transform = parent.transform.translated(linear_velocity * delta)
		
	

func applyBreak() -> void:
	var current_velocity: Vector3 = transform.basis * linear_velocity
	for i in range (3):
		if abs(linear_velocity[i]) >= acceleration_rate[i]:
			pending_impulse[i] = -1 if current_velocity[i] >= 0 else 1
		else:
			linear_velocity[i] = 0
			pending_impulse[i] = 0

func _handlePendingImpulse(delta: float) -> void:
	var transformed_impulse = transform.basis * (pending_impulse * acceleration_rate)
	linear_velocity += transformed_impulse * delta
	
	pending_impulse = Vector3.ZERO

func _handlePendingRotation(delta: float) -> void:
	
	# rotation has x=roll, y=yaw, z=pitch
	if abs(pending_rotation.x) > 0: # adjust roll
		rotation.x = clamp(rotation.x - (pending_rotation.x * rotation_rate.x * delta), -360, 360)
	if abs(pending_rotation.y) > 0: # adjust yaw
		rotation.y = clamp(rotation.y - (pending_rotation.y * rotation_rate.y * delta), -360, 360)
	if abs(pending_rotation.z) > 0: # adjust pitch
		rotation.z = clamp(rotation.z - (pending_rotation.z * rotation_rate.z * delta), -360, 360)
		
	pending_rotation = Vector3.ZERO
