extends CSGBox3D

@export var scene_to_load_path: String 
@onready var interactable_component: Node3D = $StaticBody3D/CollisionShape3D/InteractableComponent


func _ready() -> void:
	interactable_component.interact = _interact
	
func _interact() -> void:
	SceneController.goto_scene(scene_to_load_path)

func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
