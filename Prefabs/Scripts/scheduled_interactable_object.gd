extends interactable_object

@export var should_be_invisible: bool = false
@export var item_name: String

func _ready() -> void:
	check_schedule()
	super()
	
		
func check_schedule():
	dialog_node = ""
	match item_name:
		"console":
			dialog_node = NpcScheduler.get_consoles_yarn_file(Globals.current_timestep, Globals.current_location)
		"box":
			dialog_node = NpcScheduler.get_boxes_yarn_file(Globals.current_timestep, Globals.current_location)
	if should_be_invisible:
		visible = !dialog_node == ""
	$CollisionShape3D.disabled = !visible
	has_dialog = false
	
