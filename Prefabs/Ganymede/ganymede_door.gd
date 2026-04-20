extends StaticBody3D

@onready var ganymede_door: MeshInstance3D = $GanymedeDoor
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var isOpen = false

func setOpen() -> void:
	isOpen = !isOpen
	ganymede_door.visible = !ganymede_door.visible
	collision_shape_3d.disabled = !collision_shape_3d.disabled
