extends StaticBody3D


@onready var interactable_component: Node3D = $InteractableComponent
@onready var dialog_component : = $DialogComponent
@export var object_id : String
@export var dialog_node : String
@export var has_dialog : bool = true

func _ready() -> void:
	self.input_event.connect(_on_input_event)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	interactable_component.interact = _interact
	interactable_component.object_id = object_id
	if has_dialog:
		assert(dialog_node != "", "Missing dialog node on object: " + name)
		dialog_component.start_node = dialog_node
	
	
func _interact() -> void:
	if has_dialog:
		dialog_component.start_dialog()
	

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	interactable_component.show_shader()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	interactable_component.hide_shader()
	pass # Replace with function body.
