extends MeshInstance3D

@onready var interactable_component: Node = $StaticBody3D/InteractableComponent

func _ready() -> void:
	interactable_component.interact = _interact

func _interact():
	print("Interact")
	
func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
