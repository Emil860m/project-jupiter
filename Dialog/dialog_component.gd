extends Node



@export var dialogue_runner: YarnDialogueRunner
@onready var line_presenter := $CanvasLayer/Control/LinePresenter
@onready var options_presenter := $CanvasLayer/Control/OptionsPresenter

func _ready():
	dialogue_runner.add_presenter(line_presenter)
	dialogue_runner.add_presenter(options_presenter)
	dialogue_runner.start_dialogue("Start")
	dialogue_runner.add_function("roll", _roll, 0)
	var coins = dialogue_runner.variable_storage.get_value("$phisical")
	print(coins)
	

func _roll():
	var i = randi_range(10, 20)
	print(i)
	return i 
