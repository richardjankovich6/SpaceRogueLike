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

var boost_ratio : Vector3 = Vector3(2, 2, 2)
var boost_active : bool = false
func activate_boost() -> void:
	boost_active = true
func deactivate_boost() -> void:
	boost_active = false


var parent:Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	parent = get_parent_node_3d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	_handlePendingRotation(delta)
	_handlePendingImpulse(delta)
	
	
	print(boost_active)
	
	
	#if parent != null:
		#parent.transform = parent.transform.translated(constant_force)
		#parent.transform = parent.transform.translated(constant_force * delta)
		
		#parent.transform = transform.basis * get_global_position()
		#parent.set_global_position(transform.basis * get_position())


func applyBreak() -> void:
	var current_velocity: Vector3 = transform.basis * linear_velocity
	for i in range (3):
		if abs(linear_velocity[i]) >= acceleration_rate[i] / 60:
			pending_impulse[i] = -1 if current_velocity[i] >= 0 else 1
		else:
			#TODO this should use pending impule rather than directly setting linear_velocity
			linear_velocity[i] = 0
			pending_impulse[i] = 0

func _handlePendingImpulse(delta: float) -> void:
	var transformed_impulse = transform.basis * (pending_impulse * acceleration_rate)
	
	if (boost_active):
		transformed_impulse = transformed_impulse * boost_ratio
	
	apply_central_force(transform.basis * (pending_impulse * acceleration_rate))
	pending_impulse = Vector3.ZERO

func _handlePendingRotation(delta: float) -> void:
	
	" rotation has x=roll, y=yaw, z=pitch "
	if abs(pending_rotation.x) > 0: # adjust roll
		rotation.x = clamp(rotation.x - (pending_rotation.x * rotation_rate.x * delta), -PI, PI)
	if abs(pending_rotation.y) > 0: # adjust yaw
		# yaw will be calculated in reverse if the pitch is "behind" the local origin
		if (rotation.z <= PI/2 and rotation.z > -PI/2):
			rotation.y = clamp(rotation.y - (pending_rotation.y * rotation_rate.y * delta), -PI, PI)
		else:
			rotation.y = clamp(rotation.y + (pending_rotation.y * rotation_rate.y * delta), -PI, PI)
	if abs(pending_rotation.z) > 0: # adjust pitch
		rotation.z = clamp(rotation.z - (pending_rotation.z * rotation_rate.z * delta), -PI, PI)
		#rotation.z = clamp(rotation.z - (pending_rotation.z * rotation_rate.z * delta), -PI/2, PI/2)
		
	#print(rotation)
	pending_rotation = Vector3.ZERO
