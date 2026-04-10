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
	dialogue_runner.start_dialogue(start_node)

func add_functions():
	
	dialogue_runner.add_function("yarn_function", godot_function, 0)


func godot_function():
	var i = randi_range(1, 20)
	print(i)
	return i 
