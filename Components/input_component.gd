extends Node
class_name input_component

func get_select_input() -> bool:
	return Input.is_action_just_pressed("move_click")
