extends CSGBox3D

@onready var interactable_component: Node = $Area3D/InteractableComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_component.interact = _on_interact


func _on_interact():
	print("Det skal være det her")


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:	
	interactable_component.handle_click(event)
	
