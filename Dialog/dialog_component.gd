extends Node



@onready var dialogue_runner := $DialogRunner# YarnDialogueRunner
@export var start_node: String = "Start"
@export var auto_start: bool = false
@onready var line_presenter := $CanvasLayer/Control/LinePresenter
@onready var options_presenter := $CanvasLayer/Control/OptionsPresenter
var has_portrait = false
func _ready():
	dialogue_runner.add_presenter(line_presenter)
	dialogue_runner.add_presenter(options_presenter)
	add_functions()
	if auto_start:
		start_dialog()

func set_character_portrait(path: String):
	var portrait = $CanvasLayer/Control/LinePresenter/Control/TextureRect
	if portrait:
		portrait.texture = load(path)
		has_portrait = true


func start_dialog():
	$CanvasLayer.visible = true
	var portrait = $CanvasLayer/Control/LinePresenter/Control
	if portrait:
		portrait.visible = has_portrait
	print(start_node)
	dialogue_runner.start_dialogue(start_node)

func add_functions():
	dialogue_runner.add_function("yarn_function", godot_function, 1)
	
	# Stat Manipulations
	dialogue_runner.add_function("resolve_outcome", EventController.resolve_outcome, 3)
	#dialogue_runner.add_function("damage_ship", ShipStats.damage_ship, 1)
	#dialogue_runner.add_function("spend_fuel", ShipStats.spend_fuel, 1)
	#dialogue_runner.add_function("pass_time", Globals.increment_timestep, 1)
	
	# Flags
	dialogue_runner.add_function("set_flag", Flags.set_flag, 1)
	dialogue_runner.add_function("get_flag", Flags.get_flag, 1)
	dialogue_runner.add_function("get_flag_uncheck", Flags.get_flag_uncheck, 1)
	dialogue_runner.add_function("unset_flag", Flags.unset_flag, 1)
	
	
	# Checks Conversations
	dialogue_runner.add_function("physical_check", PlayerStats.physical_check, 1)
	dialogue_runner.add_function("mental_check", PlayerStats.mental_check, 1)
	dialogue_runner.add_function("social_check", PlayerStats.social_check, 1)
	dialogue_runner.add_function("education_check", PlayerStats.education_check, 1)
	
	# Checks Events
	dialogue_runner.add_function("simple_d_check", EventController.simple_durability_check, 1)
	dialogue_runner.add_function("simple_m_check", EventController.simple_maneuverability_check, 1)
	dialogue_runner.add_function("simple_r_check", EventController.simple_radiation_check, 1)
	
	dialogue_runner.add_function("stakes_d_check", EventController.stakes_durability_check, 0)
	dialogue_runner.add_function("stakes_m_check", EventController.stakes_maneuverability_check, 0)
	dialogue_runner.add_function("stakes_r_check", EventController.stakes_radiation_check, 0)
	
	dialogue_runner.add_function("detriment_s_check", EventController.detriment_speed_check, 0)

func add_non_global_function(yarn_func_name, function: Callable):
	dialogue_runner.add_function(yarn_func_name, function, function.get_argument_count())

func godot_function(string: String):
	print(string)
