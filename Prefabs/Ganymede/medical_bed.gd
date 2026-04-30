extends StaticBody3D


@onready var interact_component: input_component = $InteractableComponent


func _ready() -> void:
	interact_component.interact = _interact
	
func _interact() -> void:
	pass

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interact_component.handle_click(event)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	interact_component.show_shader()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	interact_component.hide_shader()
	pass # Replace with function body.
