#extends Camera3D
extends Node3D

@onready var camera : Camera3D = $Camera3D

var playerShip: RigidBody3D
const cameraOffset: Vector3 = Vector3(-5, 1, 0)

const cameraDistance: float = 5
const boostedModifier: float = 1.25
var currentDistance: float = 5
var boostAlpha: float = 0

const cameraFOV: float = 90

var boost_active : bool = false
func activate_boost() -> void:
	boost_active = true
func deactivate_boost() -> void:
	boost_active = false

func _ready() -> void:
	playerShip = get_parent_node_3d().get_child(0)
	#cameraOffset = camera.get_position()

func _physics_process(delta: float) -> void:
	set_rotation(playerShip.rotation)
	set_position(playerShip.position)
	
	if (boost_active):
		boostAlpha = clamp(boostAlpha + delta, 0, 1)
	else:
		boostAlpha = clamp(boostAlpha - delta, 0, 1)
		
	camera.fov = lerp(cameraFOV, cameraFOV / boostedModifier, boostAlpha)
	currentDistance = lerp(cameraDistance, cameraDistance * boostedModifier, boostAlpha)
	
	camera.set_position(cameraOffset.normalized() * currentDistance)
	
