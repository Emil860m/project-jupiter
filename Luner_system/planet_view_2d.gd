extends Node2D


var selected: StaticBody2D
@export var camera_2d: Camera2D
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_2d_component = $Raycast2dComponent


func _ready() -> void:
	raycast_comp.camera_2d = camera_2d

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
