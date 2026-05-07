extends StaticBody3D

class_name interactable_object
@onready var interactable_component: Node3D = $InteractableComponent
@onready var dialog_component : = $DialogComponent
@export var object_id : String
@export var dialog_node : String
@export var has_dialog : bool = true
@export var has_outline: bool = true
@export var portrait_path: String = ""



func _ready() -> void:
	self.input_event.connect(_on_input_event)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	if has_outline:
		interactable_component.interact = _interact
		interactable_component.object_id = object_id
	if has_dialog:
		assert(dialog_node != "", "Missing dialog node on object: " + name)
		dialog_component.start_node = dialog_node
	if portrait_path != "":
		dialog_component.set_character_portrait(portrait_path)
	
	
func _interact() -> void:
	if has_dialog:
		dialog_component.start_dialog()
	

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	if has_outline:
		interactable_component.show_shader()


func _on_mouse_exited() -> void:
	if has_outline:
		interactable_component.hide_shader()
