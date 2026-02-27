extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker


func _physics_process(delta: float) -> void:
	var next_path_point := navigation_agent_3d.get_next_path_position()
	var new_velocity := (next_path_point - global_position).normalized() * SPEED
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	
	move_and_slide()
	
func _process(delta: float) -> void:
	camera_3d.global_position = camera_marker.global_position
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			move_to_click(event)
			
func move_to_click(event: InputEvent):
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = camera_3d.project_ray_origin(event.position)
	params.to = camera_3d.project_position(event.position, 1000)
	var world_space = get_world_3d().direct_space_state
	var cursorPos = world_space.intersect_ray(params)
	navigation_agent_3d.target_position = cursorPos.position
	
