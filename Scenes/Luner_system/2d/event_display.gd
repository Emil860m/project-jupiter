extends Node2D

@onready var backdrop := $Backdrop
@onready var dialog_component := $DialogComponent
@onready var dialog_runner := $DialogComponent/DialogRunner

var callback: Callable

func _ready():
	dialog_runner.connect("dialogue_completed", _on_dialog_completed)
	dialog_component.start_node = EventController.fetch_event()
	dialog_component.start_dialog()
	
	backdrop.size = get_viewport().size
	backdrop.position -= backdrop.size / 2

func set_completion_callback(new_callback: Callable):
	callback = new_callback

func _on_dialog_completed():
	callback.call()
