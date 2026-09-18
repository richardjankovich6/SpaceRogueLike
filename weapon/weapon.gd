extends Node3D

@export var damage: float = 30
@export var weaponRange: float = 500
@export var fireRotation: Vector3 = Vector3(0, 0, 0)
var currentFireRotation: Vector3 = fireRotation

@export var cooldownDuration: float = 0.3
var cooldownElapsed: float = 0

@onready var emitter: Node3D = $Barrel/Emitter
@onready var beamMesh: MeshInstance3D = $Barrel/Emitter/BeamMesh

var fireFromPosition: Vector3

var isFiring: bool = false
var targetVector: Vector3 = Vector3.ZERO

@onready var defaultBeamHight: float = $Barrel/Emitter/BeamMesh.mesh.height
@onready var defaultBeamPosition: Vector3 = $Barrel/Emitter/BeamMesh.position

func _ready() -> void:
	fireFromPosition = $Barrel/Emitter.transform.origin

func fire(targetPoint: Vector3) -> void:
	if isFiring:
		return
	
	cooldownElapsed = 0
	isFiring = true
	targetVector = targetPoint
	var bullet = get_world_3d().direct_space_state
	var collision = bullet.intersect_ray(PhysicsRayQueryParameters3D.create(fireFromPosition, targetPoint))
	if collision:
		if collision.collider.is_in_group("shootable"):
			#print("hit shootable object ", collision.collider)
			collision.collider.wasShot(damage)
			targetVector = collision.position

func _process(delta: float) -> void:
	if isFiring:
		var diff: Vector3 = fireFromPosition - to_local(targetVector)
		var t = min(abs(diff.length()), weaponRange)
		#var t = -(fireFromPosition - targetVector).length()
		#print(fireFromPosition, targetVector, t)
		#var castPoint = to_local(targetVector)
		#var f = atan2((fireFromPosition - to_local(targetVector)).x, (fireFromPosition - to_local(targetVector)).y) + PI * 0.5
		#var x = atan2((fireFromPosition - to_local(targetVector)).x, t) + PI * 1.5
		#var x = atan(t) + PI * 0.5
		
		# x is z and x is z
		var z = atan2(diff.y, diff.x) + PI * 0
		var x = atan2(diff.y, diff.z) + PI * 0
		currentFireRotation.x = x *1
		currentFireRotation.z = z *1
		#currentFireRotation.z = emitter.rotation.z
		currentFireRotation.y = emitter.rotation.y
		
		#currentFireRotation.x = 5
		
		#emitter.set_rotation(currentFireRotation)
		#emitter.set_rotation_degrees(currentFireRotation)
		#print(currentFireRotation)
		#print(t)
		
		beamMesh.mesh.height = t
		beamMesh.position.y = -t * 0.5
		
		
		
		cooldownElapsed += delta
		if cooldownElapsed >= cooldownDuration:
			isFiring = false
			beamMesh.mesh.height = defaultBeamHight
			beamMesh.position = defaultBeamPosition
		#print(cooldownElapsed)



#func customCollide():
	#var collision = get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(fireFromPosition, targetPoint))
	
