extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.TOWTRUCK
@onready var label: Label = $CanvasLayer/Label

const tow_truck_punishment = 20

func _ready() -> void:
	ShipStats.refuel()
	Globals.increment_timestep(tow_truck_punishment)

func _on_travel_button_button_up() -> void:
	Globals.current_moon = "ThePonds"
	SceneController.goto_scene("res://Scenes/Ponds/ponds.tscn")
