extends Node
class_name input_component
@export var func_on_click: Callable
@export var camera_3d: Camera3D
@export var world_space: Node3D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			handle_lmb(event)
			

func handle_lmb(event: InputEvent):

	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = camera_3d.project_ray_origin(event.position)
	params.to = camera_3d.project_position(event.position, 1000)
	var world_space = world_space.get_world_3d().direct_space_state
	var cursorPos = world_space.intersect_ray(params)
	if cursorPos.has("collider"):
		func_on_click.call(cursorPos.collider)
