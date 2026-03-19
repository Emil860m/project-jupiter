extends Node


var current_timestep = 0
@export var moon_movement_per_timestep: float = 60.0/144.0
var max_travel_distance = 360
var current_moon: String = "Ganymede" # todo: set default moon
@export_subgroup("Ship stats")
@export var travel_speed: float = 1
