extends interactable_object

@export var should_be_invisible: bool = false
@export var item_name: String

func _ready() -> void:
	SignalBus.time_step_changed.connect(check_schedule)
	check_schedule()
	super()
	
		
func check_schedule():
	dialog_node = ""
	match item_name:
		"console":
			print("det her sker")
			print(Globals.convert_timesteps_to_time(Globals.current_timestep))
			dialog_node = NpcScheduler.get_consoles_yarn_file(Globals.current_timestep, Globals.current_location)
		"box":
			dialog_node = NpcScheduler.get_boxes_yarn_file(Globals.current_timestep, Globals.current_location)
	if should_be_invisible:
		visible = !dialog_node == ""
	$CollisionShape3D.disabled = !visible
	has_dialog = !dialog_node == "" and has_dialog
	if has_dialog:
		super._set_dialog()
	
