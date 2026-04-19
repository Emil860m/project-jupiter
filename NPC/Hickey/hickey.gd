extends StaticBody3D


@export var defaultYarnNode: String = "hickWorkshopTS3"
@export var time_pass: int = 5
@onready var dialogComp:= $DialogComponent
@onready var interactable_component: Node = $InteractableComponent
@onready var currentYarnNode: String = defaultYarnNode
func _ready() -> void:
	if Globals.current_moon == "Ganymede":
		if Globals.current_timestep >= 6:
			currentYarnNode = "hickHospitalTS6"
	
	elif Globals.current_moon == "Callisto": 
		if Globals.current_timestep >= 6:
			currentYarnNode = "hickWorkshopTS6"
		elif Globals.current_timestep >= 5:
			currentYarnNode = "hickWorkshopTS5"
		elif Globals.current_timestep >= 3:
			currentYarnNode = "hickWorkshopTS3"
	dialogComp.start_node = currentYarnNode
	interactable_component.time_pass = time_pass
	interactable_component.interact = _interact


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	print("dsfajdhbsauhd " + dialogComp.start_node)
	
	
func _interact():
	dialogComp.start_dialog()
