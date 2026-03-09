extends Node3D
class_name raycast_component
@export var camera_3d: Camera3D


func send_raycast_from_screen():

	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = camera_3d.project_ray_origin(get_window().get_mouse_position())
	params.to = camera_3d.project_position(get_window().get_mouse_position(), 1000)
	var world_space = get_world_3d().direct_space_state
	var cursorPos = world_space.intersect_ray(params)
	if cursorPos.has("collider"):
		return cursorPos #func_on_click.call(cursorPos.collider)
