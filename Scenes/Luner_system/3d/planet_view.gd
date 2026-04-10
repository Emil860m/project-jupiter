extends Node3D

var selected: StaticBody3D
@export var camera_3d: Camera3D
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_component = $RaycastComponent
@onready var moons: Node3D = $MoonParent

func _ready() -> void:
	raycast_comp.camera_3d = camera_3d
	var current_location = get_node("MoonParent/" + Globals.current_moon).global_position

	for m in moons.get_children():
		for i in range(Globals.max_travel_distance):
			if current_location.distance_to(m.get_position_at_time(Globals.current_timestep + i)) <= Globals.travel_speed * i:
				print(m.name + ": " + str(i))
				m.set_estimated_loc(i)
				break
	



	for m in moons.get_children():
		var _max = Globals.max_travel_distance
		var _min = 0
		var reach = Globals.travel_speed
		while _max > _min + 1:
			var half = round((_max + _min) / 2)
			reach = round(half * Globals.travel_speed)
			if current_location.distance_to(m.get_position_at_time(half)) < reach:
				_max = half
			else:
				_min = half
#		m.set_estimated_loc(reach)
		print(m.name + ": " + str(reach))
			
	

func _process(_delta: float) -> void:
	if input_comp.get_select_input():
		select_moon(raycast_comp.send_raycast_from_screen())

func select_moon(hit):
	if selected != null:
		selected.set_selected(false)
	if hit == null:
		return
	if not hit.has("collider"):
		return
	if hit.collider.name == Globals.current_moon:
		return
	
	if hit.collider.is_in_group("moon"):
		selected = hit.collider
		selected.set_selected(true)
