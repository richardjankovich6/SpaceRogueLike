extends Node3D

@export var damage: float = 50
@export var weaponRange: float = 1000

@onready var emitter = $Body/Barrel/Emitter


func fire(targetPoint: Vector3) -> void:
	var bullet = get_world_3d().direct_space_state
	var collision = bullet.intersect_ray(PhysicsRayQueryParameters3D.create(emitter.transform.origin, targetPoint))
	if collision:
		if collision.collider.is_in_group("shootable"):
			#print("hit shootable object ", collision.collider)
			collision.collider.wasShot(damage)
