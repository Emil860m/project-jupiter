extends StaticBody3D


@export var jupiter: StaticBody3D
@export var speed: float = 50.0
@export var distance: float = 10.0
@export var starting_angle: float = 0.0
var angle: float = 0.0

func _ready() -> void:
	global_position = new_pos(5)
	
	
func new_pos(delta) -> Vector3:
	angle += deg_to_rad(speed) * delta
	
	var x = jupiter.global_position.x + cos(starting_angle + angle) * distance
	var z = jupiter.global_position.z + sin(starting_angle + angle) * distance
	var y = jupiter.global_position.y + cos(starting_angle + angle) * distance
	return Vector3(x, y, z)

func rotate_around(point, axis, angle):
	
	# Get transform
	var trans = transform

	# Rotate its basis
	var rotated_basis = trans.basis.rotated(axis, angle)

	# Rotate its origin
	var rotated_origin = point + (trans.origin - point).rotated(axis, angle)

	# Set the result back
	transform = Transform3D(rotated_basis, rotated_origin)
