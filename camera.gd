extends Camera3D


@export
var player: CharacterBody3D

const RAY_LENGTH = 1000

func _physics_process(delta):
	if Input.is_action_just_pressed("Click"):
		var mouse_position := get_window().get_mouse_position()
		var camera         := get_window().get_viewport().get_camera_3d()
		var plane          := Plane.PLANE_XZ

		var intersect : Variant = plane.intersects_ray(
			project_ray_origin(mouse_position),
			project_ray_normal(mouse_position)
		)
		intersect.y = player.global_position.y
		# Prints either null or the Vector3 where the raycast intersects the zero-plane:
		player.target_location = intersect
		
