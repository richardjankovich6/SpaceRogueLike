extends RayCast3D

@onready var beamMesh: MeshInstance3D = $BeamMesh

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var castPoint: Vector3
	force_raycast_update()
	
	if is_colliding():
		castPoint = to_local(get_collision_point())
		beamMesh.mesh.height = castPoint.y
		beamMesh.position.y = castPoint.y * 0.5
