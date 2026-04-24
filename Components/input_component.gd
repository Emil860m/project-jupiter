extends Node
class_name input_component

func get_select_input() -> bool:
	if Input.is_action_just_pressed("move_click"):
		if !Globals.interacting:
			return true
	return false
