extends StaticBody3D

@onready var ganymede_door: MeshInstance3D = $GanymedeDoor
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var isOpen = false

func setOpen() -> void:
	isOpen = true
	ganymede_door.visible = false
	collision_shape_3d.disabled = true

func setClosed() -> void:
	isOpen = false
	ganymede_door.visible = true
	collision_shape_3d.disabled = false
