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
@export var travelScenePath: String
@export var loading_screen: bool = false
@export var main_poster: String
@export var other_posters: Array[String]
var current_angle: float = 0.0
var selected: bool = false
var base_travel_time: int
var estimated_travel_time: int

@onready var estimated_loc: Sprite2D = $estimated_loc
@onready var youAreHere: Sprite2D = $YouAreHere
@onready var selectedSprite: Sprite2D = $selected
@onready var direction: Node2D = $estimated_loc/direction

const MINUTES_PER_DAY = 1440

func set_selected(b: bool):
	selected = b
	#estimated_loc.visible = b
	selectedSprite.visible = b
	direction.visible = b
#var time = 0
#func _process(delta: float) -> void:
#	time += delta
#	if time > 0.2:
#		Globals.current_timestep += 1
#		set_orbital_position()
#		time = 0
		
func _ready() -> void:
	$Sprite2D.texture = sprite
	estimated_loc.texture = sprite
	current_angle = starting_angle
	
	set_orbital_position(Globals.current_timestep)
	estimated_loc.global_position = get_position_at_time(Globals.current_timestep + 5)
	#estimated_loc.visible = false
	direction.visible = false
	estimated_loc.self_modulate.a = 0.5
	
func set_orbital_position(time):
	global_position = get_position_at_time(time)

func set_estimated_loc(timestep, travel_time, current_loc):
	estimated_loc.global_position = get_position_at_time(travel_time + timestep)
	direction.look_at(current_loc)
	estimated_loc.visible = true
	#estimated_travel_time = timestep

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
