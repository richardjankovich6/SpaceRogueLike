extends Node3D


@export var targetingRange: float = 1500

@onready var beamMesh: MeshInstance3D = $RayCast3D/LaserBeam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var targetPosition = Vector3(targetingRange, 0, 0)
	var bullet = get_world_3d().direct_space_state
	var collision = bullet.intersect_ray(PhysicsRayQueryParameters3D.create(Vector3.ZERO, targetPosition))
	if collision:
		targetPosition = collision.position
			
	var diff: Vector3 = to_local(targetPosition)
	var t = min(abs(diff.length()), targetingRange)
	beamMesh.mesh.height = t
	beamMesh.position.x = t * 0.5
	print(beamMesh.position)
