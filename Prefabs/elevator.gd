extends StaticBody3D

@export var scene_to_load_path: String
@onready var interactable_component: Node3D = $InteractableComponent
@onready var elevator_shaft: MeshInstance3D = $ElevatorShaft

@export var show_shaft: bool = false
@export var object_id : String

func _ready() -> void:
	interactable_component.object_id = object_id
	elevator_shaft.visible = show_shaft
	interactable_component.interact = _interact
	SoundController.play_elevator()
	
func _interact() -> void:
	SceneController.goto_scene(scene_to_load_path)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)


func _on_mouse_entered() -> void:
	interactable_component.show_shader()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	interactable_component.hide_shader()
	pass # Replace with function body.
