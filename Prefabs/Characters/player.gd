extends CharacterBody3D

const SPEED = 4

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent
@onready var movement_component: Node = $MovementComponent
@onready var movement_timer: Timer = $MovementTimer
@onready var clock_label := $Camera3D/CanvasLayer/Label

@export var interact_dist = 2.5

var interact_object: Node = null
var interact_click: bool = false

var can_move = true

var pause_scene = preload("res://Scenes/Misc/pause_menu.tscn")

func _ready() -> void:
	movement_timer.start(0.5)
	can_move = false
	SignalBus.object_clicked.connect(_on_object_clicked)
	clock_label.text = Globals.convert_timesteps_to_string(Globals.current_timestep)
	raycast_comp.camera_3d = camera_3d
	camera_3d.global_position = camera_marker.global_position

func _physics_process(delta: float) -> void:
	if interact_object != null:
		if interact_object.global_position.distance_to(self.global_position) < interact_dist:
			navigation_agent_3d.target_position = self.global_position
			interact_object.runner()
			interact_object = null
			clock_label.text = Globals.convert_timesteps_to_string(Globals.current_timestep)
	velocity = movement_component.set_movement_velocity(
		navigation_agent_3d.get_next_path_position(),
		global_position,
		SPEED
		)
	move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var pause_scene_instance = pause_scene.instantiate()
		add_child(pause_scene_instance)
		get_tree().paused = true
	if Globals.interacting:
		can_move = false
		return
	if !can_move && movement_timer.time_left <= 0:
		can_move = true
		return
	if can_move:
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


func _on_movement_timer_timeout() -> void:
	can_move = true
	pass # Replace with function body.
