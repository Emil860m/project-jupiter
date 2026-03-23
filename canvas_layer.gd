extends Control

@onready var time_label: Label = $TimeLabel

func _ready() -> void:
	SignalBus.time_step_changed.connect(_on_time_changed)
	_on_time_changed()
	
func _on_time_changed():
	time_label.text = "Current timestep: %s" % Globals.current_timestep
