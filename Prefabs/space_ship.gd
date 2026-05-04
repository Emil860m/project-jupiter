extends StaticBody3D

@onready var interactable_component: Node3D = $InteractableComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_component.interact = _interact
	interactable_component.object_id = "SpaceShip"
	pass # Replace with function body.

func _interact() -> void:
	pass

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	interactable_component.show_shader()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	interactable_component.hide_shader()
	pass # Replace with function body.
