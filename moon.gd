extends StaticBody3D


@export var center: StaticBody3D
@export var speed: float = 50.0
@export var orbital_period: float = 1 # in days
@export var radius: float = 10.0
@export var starting_angle: float = 0.0
@export var inclination: float = 0.0
@export var eccentricity: float = 0.0
var current_angle: float = 0.0

const MINUTES_PER_DAY = 1440

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_click"):
		Globals.current_timestep += 5
		set_orbital_position()
		#global_position = get_position_at_time(Globals.moon_movement_per_timestep)
		#current_angle += deg_to_rad(speed) * Globals.moon_movement_per_timestep
		#print(current_angle)
func _ready() -> void:
	current_angle = starting_angle
	global_position = get_position_at_time(0)
	
func set_orbital_position():
	#current_angle += deg_to_rad(speed) * Globals.moon_movement_per_timestep
	global_position = get_position_at_time(Globals.current_timestep)
	#Globals.current_timestep += 1
	
func get_position_at_time(timestep) -> Vector3:
	var angle = deg_to_rad(speed) * timestep * Globals.moon_movement_per_timestep
	var x = center.global_position.x + cos(starting_angle + angle) * radius 
	var z = center.global_position.z + sin(starting_angle + angle) * radius * (1.0 - eccentricity)
	#var y = jupiter.global_position.y + cos(starting_angle + angle) * distance
	
	return Vector3(x, center.global_position.y, z)
