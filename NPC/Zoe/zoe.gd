extends StaticBody3D



@export var time_pass: int = 5
@onready var dialogComp:= $DialogComponent
@onready var interactable_component: Node = $InteractableComponent
var currentYarnNode: String = ""

func _ready() -> void:
	currentYarnNode = NpcScheduler.get_zoe_yarn_file(Globals.current_timestep, Globals.current_location)
	if currentYarnNode == "":
		visible = false
	dialogComp.start_node = currentYarnNode
	interactable_component.time_pass = time_pass
	interactable_component.interact = _interact


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	print("dsfajdhbsauhd " + dialogComp.start_node)
	
	
func _interact():
	dialogComp.start_dialog()
