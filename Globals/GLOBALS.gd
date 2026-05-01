extends Node

var interacting = false
var interacted_set = {}

var current_timestep = 0
var minutes_per_timestep: int = 3
var minutes_before_timestep_zero: int = 460 # 7:40
var max_hour = 25


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
	
	if convert_timesteps_to_time(current_timestep)[0] >= max_hour:
		SceneController.goto_scene("res://Scenes/EndingScene.tscn")


func add_to_interact_set(item) -> void:
	interacted_set[item] = null
func has_interacted(item) -> bool:
	return interacted_set.has(item)

func set_interacting_false():
	interacting = false

# Chapter management
var current_chapter: int = 1
var chapter_titles: Array[String] = [
	"EVEN JUPITER IS BOUND BY TIME",
	"GANYMEDE AND THE EAGLE"
]

func get_current_chapter_title():
	return chapter_titles[current_chapter - 1]

func advance_chapter():
	current_chapter += 1
	
	
func convert_timesteps_to_time(timestep: int):
	var minutes = (timestep * minutes_per_timestep) + minutes_before_timestep_zero
	var hours = minutes / 60
	minutes = minutes % 60
	return [hours, minutes]
	
func convert_timesteps_to_string(timestep: int):
	var timeArr = convert_timesteps_to_time(timestep)
	return ("" if timeArr[0] >= 10  else "0") + str(timeArr[0]) + ":" + ("" if timeArr[1] >= 10  else "0") + str(timeArr[1])
