extends Node2D

@onready var dialog_component := $CanvasLayer/EventComponent
@onready var dialog_runner: YarnDialogueRunner = dialog_component.dialogue_runner

var callback: Callable

func _ready():
	dialog_runner.connect("dialogue_completed", _on_dialog_completed)
	

func start(start_time: int, end_time: int, start_pos: moon_2d, end_pos: moon_2d):
	dialog_component.start_node = EventController.fetch_event(start_time, end_time, start_pos, end_pos)
	dialog_component.start_dialog()

func set_completion_callback(new_callback: Callable):
	callback = new_callback

func _on_dialog_completed():
	callback.call()
