extends Node2D


var selected: Area2D
@export var camera_2d: Camera2D
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_2d_component = $Raycast2dComponent
@onready var moons: Node2D = $MoonParent
var current_location: moon_2d

func _ready() -> void:
	raycast_comp.camera_2d = camera_2d
	current_location = get_node("MoonParent/" + Globals.current_moon)
	var current_location_vector = current_location.global_position
	current_location.youAreHere.visible = true
	for m in moons.get_children():
		m.planetview = self
		for i in range(Globals.max_travel_distance):
			if current_location_vector.distance_to(m.get_position_at_time(Globals.current_timestep + i)) <= Globals.travel_speed * i:
				print(m.name + ": " + str(i))
				m.set_estimated_loc(i, current_location_vector)
				break

func _process(_delta: float) -> void:
	if input_comp.get_select_input():
		pass
		#select_moon(raycast_comp.send_raycast_from_screen())

func select_moon(hit):
	print(hit)
	if hit == null:
		return
	if hit == current_location:
		return
	if selected != null:
		selected.set_selected(false)
	if hit.is_in_group("moon"):
		selected = hit
		selected.set_selected(true)
	
