extends CharacterBody3D

const SPEED = 4

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent
@onready var movement_component: Node = $MovementComponent
@onready var stop_move_timer: Timer = $StopMoveTimer

@export var interact_dist = 2.5

var interact_object: Node = null
var interact_click: bool = false

var can_move = true


func _ready() -> void:
	can_move = false
	stop_move_timer.start(1)
	raycast_comp.camera_3d = camera_3d
	SignalBus.object_clicked.connect(_on_object_clicked)

func _physics_process(delta: float) -> void:
	if interact_object != null:
		if interact_object.global_position.distance_to(self.global_position) < interact_dist:
			navigation_agent_3d.target_position = self.global_position
			interact_object.runner()
			interact_object = null
	velocity = movement_component.set_movement_velocity(
		navigation_agent_3d.get_next_path_position(),
		global_position,
		SPEED
		)
	move_and_slide()
	
func _process(delta: float) -> void:
	if Globals.interacting:
		can_move = false
		return
	if !can_move:
		if !Globals.interacting:
			can_move = true
		return
	if input_comp.get_select_input():
		if !interact_click:
			interact_object = null
		interact_click = false
		handle_raycast(raycast_comp.send_raycast_from_screen())
	camera_3d.global_position = camera_marker.global_position

func handle_raycast(hit):
	if hit == null:
		return
	if hit.has("position"):
		navigation_agent_3d.target_position = hit.position
	camera_3d.global_position = camera_marker.global_position
	
	
func _on_object_clicked(object: Node):
	interact_object = object
	interact_click = true


func _on_stop_move_timer_timeout() -> void:
	can_move = true
