extends Node2D

@onready var label: Label = $CanvasLayer/Label

const tow_truck_punishment = 20

func _ready() -> void:
	Globals.increment_timestep(tow_truck_punishment)

func _on_travel_button_button_up() -> void:
	SceneController.goto_scene("res://Scenes/Ponds/ponds.tscn")
