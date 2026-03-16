extends Node2D

class_name raycast_2d_component
@export var camera_2d: Camera2D

func send_raycast_from_screen():
	var params = PhysicsRayQueryParameters2D.new()
	
	params.from = camera_2d.project_ray_origin(get_window().get_mouse_position())
	params.to = camera_2d.project_position(get_window().get_mouse_position(), 1000)
	var world_space = get_world_2d().direct_space_state
	var cursorPos = world_space.intersect_ray(params)
	if cursorPos.has("collider"):
		return cursorPos #func_on_click.call(cursorPos.collider)
