extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.TOWTRUCK
@onready var label: Label = $CanvasLayer/Label
@onready var _animated_sprite_1 = $CanvasLayer/chuj

func _ready() -> void:
	_animated_sprite_1.play("default")
	if ShipStats.fuel <= 0:
		label.text = "You did not have the necessary fuel to reach your destination.\nYour ship has been towtrucked."
	elif ShipStats.damage > 10:
		label.text = "Your ship has taken serious damage, and systems are no longer operational.\nYour ship has been towtrucked."
	else:
		label.text = "Your ship has been towtrucked"
	SceneController.should_tow_truck = false
	Globals.increment_timestep(Globals.tow_truck_punishment)

func _on_travel_button_button_up() -> void:
	Globals.current_moon = "ThePonds"
	SceneController.goto_scene("res://Scenes/Ponds/ponds.tscn")
