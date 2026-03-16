extends StaticBody2D


class_name moon_2d
@export var center: StaticBody3D
@export var speed: float = 50.0
@export var orbital_period: float = 1 # in days
@export var radius: float = 10.0
@export var starting_angle: float = 0.0
@export var inclination: float = 0.0
@export var eccentricity: float = 0.0
var current_angle: float = 0.0
var selected: bool = false

@onready var estimated_loc: Sprite2D = $estimated_loc

const MINUTES_PER_DAY = 1440

func set_selected(b: bool):
	selected = b
	estimated_loc.visible = b
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("move_click"):
#		Globals.current_timestep += 5
#		set_orbital_position()
#		set_estimated_loc(5)
		
func _ready() -> void:
	current_angle = starting_angle
	global_position = get_position_at_time(0)
	estimated_loc.global_position = get_position_at_time(Globals.current_timestep + 5)
	estimated_loc.visible = false
	
func set_orbital_position():
	global_position = get_position_at_time(Globals.current_timestep)

func set_estimated_loc(timestep):
	estimated_loc.global_position = get_position_at_time(Globals.current_timestep + timestep)
	
func get_position_at_time(timestep) -> Vector2:
	if center != null:
		var angle = deg_to_rad(speed) * timestep * Globals.moon_movement_per_timestep
		var x = center.global_position.x + cos(starting_angle + angle) * radius 
		var z = center.global_position.z + sin(starting_angle + angle) * radius * (1.0 - eccentricity)
		
		return Vector2(x, center.global_position.y)
	return Vector2.ZERO
