extends Node3D

var selected: StaticBody3D
@export var camera_3d: Camera3D
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent

func _ready() -> void:
	raycast_comp.camera_3d = camera_3d

func _process(_delta: float) -> void:
	if input_comp.get_select_input():
		select_moon(raycast_comp.send_raycast_from_screen())

func select_moon(hit):
	if hit == null:
		return
	if not hit.has("collider"):
		return
	if selected != null:
		selected.set_selected(false)
	
	if hit.collider.is_in_group("moon"):
		selected = hit.collider
		selected.set_selected(true)
