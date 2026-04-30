extends StaticBody3D

@onready var ganymede_door: MeshInstance3D = $GanymedeDoor
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var interactable_component: Node3D = $InteractableComponent

var isOpen = false
@export var object_id : String

func _ready() -> void:
	interactable_component.interact = _interact
	interactable_component.object_id = object_id
	
func _interact() -> void:
	isOpen = !isOpen
	if isOpen:
		ganymede_door.visible = false
		collision_layer = 2
	else:
		ganymede_door.visible = true
		collision_layer = 1
		
		
func setOpen() -> void:
	isOpen = true
	ganymede_door.visible = false
	collision_layer = 2
	
	
func setClosed() -> void:
	isOpen = false
	ganymede_door.visible = true
	collision_layer = 1


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	interactable_component.show_shader()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	interactable_component.hide_shader()
	pass # Replace with function body.
