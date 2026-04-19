extends StaticBody3D


@export var defaultYarnNode: String = "kasHospitalTS1"
@export var time_pass: int = 5
@onready var dialogComp:= $DialogComponent
@onready var interactable_component: Node = $InteractableComponent
@onready var currentYarnNode: String = defaultYarnNode
func _ready() -> void:
	if Globals.current_moon == "Ganymede":
		if Globals.current_timestep >= 7:
			currentYarnNode = "kasHospitalTS7"
		elif Globals.current_timestep >= 4:
			currentYarnNode = "kasHospitalTS4"
		else:
			currentYarnNode = "kasHospitalTS1"
	
	elif Globals.current_moon == "Callisto": 
		if Globals.current_timestep >= 5:
			currentYarnNode = "kasWorkshopTS5"
	dialogComp.start_node = currentYarnNode
	interactable_component.time_pass = time_pass
	interactable_component.interact = _interact


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	print("dsfajdhbsauhd " + dialogComp.start_node)
	
	
func _interact():
	dialogComp.start_dialog()
