extends CharacterBody3D


const SPEED = 5.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent

@export var movement: Node


func _ready() -> void:
	raycast_comp.camera_3d = camera_3d

func _physics_process(delta: float) -> void:
	velocity = movement.set_movement_velocity(
		navigation_agent_3d.get_next_path_position(),
		global_position,
		SPEED
		)
	
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if input_comp.get_select_input():
		handle_raycast(raycast_comp.send_raycast_from_screen())
	camera_3d.global_position = camera_marker.global_position

func handle_raycast(hit):
	if hit == null:
		return
	if hit.has("position"):
		navigation_agent_3d.target_position = hit.position
	
