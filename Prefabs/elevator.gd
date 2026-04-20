extends StaticBody3D

@export var scene_to_load_path: String
@onready var interactable_component: Node3D = $InteractableComponent
@onready var elevator_shaft: MeshInstance3D = $ElevatorShaft

@export var show_shaft: bool = false

func _ready() -> void:
	elevator_shaft.visible = show_shaft
	interactable_component.interact = _interact
	
func _interact() -> void:
	SceneController.goto_scene(scene_to_load_path)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
