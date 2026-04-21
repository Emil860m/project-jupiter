extends Node

var interacted_set = {}
var current_timestep = 0
@export var moon_movement_per_timestep: float = 20.0/144.0
var max_travel_distance = 360
var current_moon: String = "OutPost" # todo: set default moon
var current_location: NpcScheduler.locations = NpcScheduler.locations.HOSPITAL:
	set(new_location):
		SoundController.set_bgm(new_location)
		current_location = new_location
@export_subgroup("Ship stats")

func increment_timestep(increment: int):
	current_timestep += increment
	SignalBus.time_step_changed.emit()


func add_to_interact_set(item) -> void:
	interacted_set[item] = null
func has_interacted(item) -> bool:
	return interacted_set.has(item)



# Chapter management
var current_chapter: int = 1
var chapter_titles: Array[String] = [
	"EVEN JUPITER IS BOUND BY TIME",
	"JUPITER AND THE EAGLE"
]

func get_current_chapter_title():
	return chapter_titles[current_chapter - 1]

func advance_chapter():
	current_chapter += 1
