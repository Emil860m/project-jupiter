extends Area2D


class_name moon_2d
var planetview: Node2D
@export var center: StaticBody2D
@export var speed: float = 50.0
@export var orbital_period: float = 1 # in days
@export var radius: float = 10.0
@export var starting_angle: float = 0.0
@export var inclination: float = 0.0
@export var eccentricity: float = 0.0
@export var sprite: Texture2D
@export var displayName: String
var current_angle: float = 0.0
var selected: bool = false
var estimated_travel_time: int

@onready var estimated_loc: Sprite2D = $estimated_loc
@onready var youAreHere: Sprite2D = $YouAreHere
@onready var selectedSprite: Sprite2D = $selected

const MINUTES_PER_DAY = 1440

func set_selected(b: bool):
	selected = b
	estimated_loc.visible = b
	selectedSprite.visible = b
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("move_click"):
#		Globals.current_timestep += 5
#		set_orbital_position()
#		set_estimated_loc(5)
		
func _ready() -> void:
	$Sprite2D.texture = sprite
	estimated_loc.texture = sprite
	current_angle = starting_angle
	global_position = get_position_at_time(0)
	estimated_loc.global_position = get_position_at_time(Globals.current_timestep + 5)
	estimated_loc.visible = false
	
func set_orbital_position():
	global_position = get_position_at_time(Globals.current_timestep)

func set_estimated_loc(timestep, current_loc):
	estimated_loc.global_position = get_position_at_time(Globals.current_timestep + timestep)
	estimated_loc.look_at(current_loc)
	estimated_travel_time = timestep

func get_position_at_time(timestep) -> Vector2:
	if center != null:
		var angle = deg_to_rad(speed) * timestep * Globals.moon_movement_per_timestep
		var x = center.global_position.x + cos(starting_angle + angle) * radius 
		var y = center.global_position.y + sin(starting_angle + angle) * radius * (1.0 - eccentricity)

		return Vector2(x, y)
	return Vector2.ZERO


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("move_click"):
		planetview.select_moon(self)
