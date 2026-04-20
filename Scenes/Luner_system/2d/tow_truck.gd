extends Node2D

@onready var label: Label = $CanvasLayer/Label
@onready var timer: Timer = $CanvasLayer/Timer

const tow_truck_punishment = 20

func _ready() -> void:
	timer.start(3)
	Globals.increment_timestep(tow_truck_punishment)
	

func _process(delta: float) -> void:
	label.text = "You did not have the necessary fuel to reach timeout. Your ship has been towtrucked and refueled.
	
	You will arraive at the ponds in %d" % timer.get_time_left()

func _on_timer_timeout() -> void:
	SceneController.goto_scene("res://Scenes/Ponds/ponds.tscn")
