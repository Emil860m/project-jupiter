extends Node



@onready var dialogue_runner := $DialogRunner# YarnDialogueRunner
@export var start_node: String = "Start"
@export var auto_start: bool = false
@onready var line_presenter := $CanvasLayer/Control/LinePresenter
@onready var options_presenter := $CanvasLayer/Control/OptionsPresenter

func _ready():
	dialogue_runner.add_presenter(line_presenter)
	dialogue_runner.add_presenter(options_presenter)
	add_functions()
	if auto_start:
		start_dialog()

	
func start_dialog():
	$CanvasLayer.visible = true
	dialogue_runner.start_dialogue(start_node)

func add_functions():
	dialogue_runner.add_function("yarn_function", godot_function, 1)
	
	# Stat Manipulations
	dialogue_runner.add_function("damage_ship", ShipStats.damage_ship, 1)
	dialogue_runner.add_function("spend_fuel", ShipStats.spend_fuel, 1)
	dialogue_runner.add_function("pass_time", Globals.increment_timestep, 1)
	
	# Checks
	dialogue_runner.add_function("simple_d_check", EventController.simple_durability_check, 1)
	dialogue_runner.add_function("simple_m_check", EventController.simple_maneuverability_check, 1)
	dialogue_runner.add_function("simple_r_check", EventController.simple_radiation_check, 1)
	
	dialogue_runner.add_function("stakes_d_check", EventController.stakes_durability_check, 0)
	dialogue_runner.add_function("stakes_m_check", EventController.stakes_maneuverability_check, 0)
	dialogue_runner.add_function("stakes_r_check", EventController.stakes_radiation_check, 0)


func godot_function(string: String):
	print(string)
