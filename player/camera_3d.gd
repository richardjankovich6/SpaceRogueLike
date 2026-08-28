#extends Camera3D
extends Node3D

var playerShip: RigidBody3D
static var cameraOffset: Vector3 = Vector3(4, 1, 0)

func _ready() -> void:
	playerShip = get_parent_node_3d().get_child(0)

func _process(delta: float) -> void:
	set_rotation(playerShip.rotation)
	#delta
