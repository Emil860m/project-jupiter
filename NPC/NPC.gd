extends StaticBody3D


@export var character_name: = ""
@export var time_pass: int = 5
@export var mood_portrait_dict: Dictionary[String, String]
@export var current_mood: String = "Happy"
@onready var dialogComp:= $DialogComponent
@onready var interactable_component: Node = $InteractableComponent
var currentYarnNode: String = ""
func _ready() -> void:
	match character_name:
		"Hickey":
			currentYarnNode = NpcScheduler.get_hickey_yarn_file(Globals.current_timestep, Globals.current_location)
		"Kassandra":
			currentYarnNode = NpcScheduler.get_kass_yarn_file(Globals.current_timestep, Globals.current_location)
		"Sally":
			currentYarnNode = NpcScheduler.get_sally_yarn_file(Globals.current_timestep, Globals.current_location)
		"Zoe":
			currentYarnNode = NpcScheduler.get_zoe_yarn_file(Globals.current_timestep, Globals.current_location)
	if currentYarnNode == "":
		visible = false
	dialogComp.start_node = currentYarnNode
	interactable_component.time_pass = time_pass
	interactable_component.interact = _interact
	interactable_component.object_id = currentYarnNode
	dialogComp.add_non_global_function("change_mood", change_mood)
	if current_mood in mood_portrait_dict.keys():
		dialogComp.set_character_portrait(mood_portrait_dict[current_mood])

func change_mood(mood: String):
	current_mood = mood

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	interactable_component.handle_click(event)
	
func _on_mouse_entered():
	interactable_component.show_shader()
	
func _on_mouse_exited():
	interactable_component.hide_shader()

func _interact():
	print(character_name)
	dialogComp.start_dialog()
