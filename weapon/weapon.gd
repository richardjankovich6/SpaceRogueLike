extends Node3D

@export var damage: float = 50
@export var weaponRange: float = 1000

@onready var emitter = $Body/Barrel/Emitter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func fire(targetPoint: Vector3) -> void:
	print("weapon fired")
	var bullet = get_world_3d().direct_space_state
	var collision = bullet.intersect_ray(PhysicsRayQueryParameters3D.create(emitter.transform.origin, targetPoint))
	if collision:
		var target = collision.collider
		if collision.collider.is_in_group("shootable"):
			print("hit shootable object ", collision.collider)
			target.wasShot(damage)
			
	pass
