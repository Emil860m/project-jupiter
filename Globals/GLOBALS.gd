extends Node

var interacted_set = {}
var current_timestep = 0
@export var moon_movement_per_timestep: float = 60.0/144.0
var max_travel_distance = 360
var current_moon: String = "Ganymede" # todo: set default moon
@export_subgroup("Ship stats")
@export var travel_speed: float = 20

func increment_timestep(increment: int):
	print(current_timestep)
	print(increment)
	current_timestep += increment
	SignalBus.time_step_changed.emit()


func add_to_interact_set(item) -> void:
	interacted_set[item] = null
	
func has_interacted(item) -> bool:
	return interacted_set.has(item)
