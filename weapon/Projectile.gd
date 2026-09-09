extends Node3D
class_name Projectile

signal Hit_Succesfull

@export_enum ("Hitscan", "Rigidbody", "Custom") var Projectile_Type: String = "Hitscan"

@export_category("Rigid Body Projectile Properties")
@export var Projectile_Velocity: int
@export var Expiration_Time: float = 10
@export var Projectile_Scene: PackedScene
@export var pass_through: bool = false


var damage: float = 0
#var Projectiles_Spawned = []
var hit_object: Array = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(Expiration_Time, false, true, false).timeout.connect(_on_timer_timeout)
	pass # Replace with function body.
	

func _set_projectile(_damage: int = 0, spread:Vector2 = Vector2.ZERO, range: int = 1000, origin: Vector3 = Vector3.ZERO, direction: Vector3 = Vector3(1, 0, 0)) -> void:
	damage = _damage
	fire_projectile(spread, range, Projectile_Scene, origin, direction)

func fire_projectile(spread: Vector2, range: int, _proj:PackedScene, origin: Vector3, direction: Vector3):
	
	match Projectile_Type:
		"Hitscan":
			hit_scan_collision(range, origin, direction)
			pass
		"Rigidbody":
			pass
		"Custom":
			pass

func hit_scan_collision(range: int, origin: Vector3, direction: Vector3):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
