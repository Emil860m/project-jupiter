extends Control
class_name StatAllocationButtonGroup

@onready var add_button = $VBoxContainer/AddButton
@onready var subtract_button = $VBoxContainer/SubtractButton
@onready var label = $Label

var type: ShipStats.ShipStatTypes
var callback: Callable

func initialize(stat_type: ShipStats.ShipStatTypes, refresh_callback: Callable):
	label.text = ShipStats.stat_type_to_string(stat_type)
	type = stat_type
	callback = refresh_callback
	
	add_button.connect("pressed", _on_add_button_pressed)
	subtract_button.connect("pressed", _on_subtract_button_pressed)
	
	update()

func update():
	add_button.disabled = ShipStats.get_unused_stat_allocation_points() == 0 or ShipStats.max_allowed_stat <= ShipStats.Stats[type]
	subtract_button.disabled = ShipStats.stat_min_allowed_value == ShipStats.Stats[type]

# Signals
func _on_add_button_pressed():
	if !Globals.interacting:
		SoundController.play_high_boop()
		ShipStats.allocate_stat(type)
		callback.call()

func _on_subtract_button_pressed():
	if !Globals.interacting:
		SoundController.play_low_boop()
		ShipStats.de_allocate_stat(type)
		callback.call()
