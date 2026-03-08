extends Node3D

var selected: StaticBody3D
@onready var input_comp: input_component = $InputComponent


func _ready() -> void:
	input_comp.func_on_click = select_moon

func select_moon(collider):
	if selected != null:
		selected.set_selected(false)
	
	selected = collider
	if selected.is_in_group("moon"):
		selected.set_selected(true)
