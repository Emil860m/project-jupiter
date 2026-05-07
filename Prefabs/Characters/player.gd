extends CharacterBody3D

signal push_done

const SPEED = 4

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent
@onready var movement_component: Node = $MovementComponent
@onready var movement_timer: Timer = $MovementTimer
@onready var clock_label := $Camera3D/CanvasLayer/Label
@onready var interact_range: CollisionShape3D = $Area3D/CollisionShape3D
@onready var animation_tree: AnimationTree = $idle/AnimationTree
@onready var skeleton_3d: Node3D = $idle

@export var interact_dist = 2.5

var interact_object: Node = null
var interact_collision_object = null
var interact_click: bool = false
var nodes_in_interact_range: Array[Node3D]
var animation_state_machine
var can_move = true
var can_click = true
var pause_scene = preload("res://Scenes/Misc/pause_menu.tscn")

func _ready() -> void:
	animation_state_machine = animation_tree["parameters/playback"]
	animation_tree.set("parameters/locomotion/blend_position", 0)
	interact_range.shape.radius = interact_dist
	movement_timer.start(0.5)
	can_move = false
	SignalBus.object_clicked.connect(_on_object_clicked)
	clock_label.text = Globals.convert_timesteps_to_string(Globals.current_timestep)
	raycast_comp.camera_3d = camera_3d
	camera_3d.global_position = camera_marker.global_position
	navigation_agent_3d.target_position = global_position

func _physics_process(delta: float) -> void:
	if round(global_position.x) == round(navigation_agent_3d.get_final_position().x) && round(global_position.z) == round(navigation_agent_3d.get_final_position().z):
		animation_tree.set("parameters/locomotion/blend_position", 0)
	else:
		var nextPoint = navigation_agent_3d.get_next_path_position()
		velocity = movement_component.set_movement_velocity(
		nextPoint,
		global_position,
		SPEED
		)
		skeleton_3d.look_at(Vector3(nextPoint.x,0,nextPoint.z), Vector3(0,1,0), true)
		skeleton_3d.global_rotation.x = 0
		move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		Globals.increment_timestep(100)
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
		if input_comp.get_select_input() && can_click:
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
	
	
func _on_object_clicked(object: Node, collision: CollisionShape3D):
	interact_object = object
	interact_collision_object = collision
	interact_click = true
	if nodes_in_interact_range.reduce(func(accum, node): return accum || node.get_node("CollisionShape3D") == interact_collision_object, false):
		_interact()

func _interact():
	navigation_agent_3d.target_position = self.global_position
	animation_state_machine.travel("Push")
	can_click = false
	await push_done
	can_click = true
	interact_object.runner()
	interact_object = null
	clock_label.text = Globals.convert_timesteps_to_string(Globals.current_timestep)

func _test():
	print("now")

func _on_movement_timer_timeout() -> void:
	can_move = true
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	nodes_in_interact_range.append(body)
	if interact_object != null:
		if body.get_node("CollisionShape3D") == interact_collision_object:
			_interact()


func _on_area_3d_body_exited(body: Node3D) -> void:
	nodes_in_interact_range.erase(body)
	pass # Replace with function body.


func _on_navigation_agent_3d_path_changed() -> void:
	animation_tree.set("parameters/locomotion/blend_position", 1)
	pass # Replace with function body.


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "KherAnimations/ButtonPush":
		push_done.emit()
	pass # Replace with function body.
