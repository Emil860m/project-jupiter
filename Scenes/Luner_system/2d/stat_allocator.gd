extends Node2D

@onready var stat_polygon := $StatPolygon
@onready var stat_points_label := $ButtonGroupMarkers/StatPointsLabel
var button_groups: Array[StatAllocationButtonGroup] = []

# Markers
@onready var r_marker := $ButtonGroupMarkers/RMarker
@onready var d_marker := $ButtonGroupMarkers/DMarker
@onready var m_marker := $ButtonGroupMarkers/MMarker
@onready var s_marker := $ButtonGroupMarkers/SMarker
@onready var f_marker := $ButtonGroupMarkers/FMarker

var button_group_scene = preload("res://Scenes/Luner_system/2d/stat_allocation_button_group.tscn")

var max_stat: float = ShipStats.max_allowed_stat
var angle = 2*PI/5
var max_radius = 200
var min_radius = max_radius / max_stat

var inner_line_count = 5

func _ready() -> void:
	init_buttons()
	draw_bg_pentagons()
	
	# Styling stat web
	stat_polygon.color = Color("badf14")
	stat_polygon.color.a = 0.85
	refresh_polygon()


# init stuff

func init_buttons():
	add_button_group(ShipStats.ShipStatTypes.radiation_protection, r_marker)
	add_button_group(ShipStats.ShipStatTypes.durability, d_marker)
	add_button_group(ShipStats.ShipStatTypes.maneuverability, m_marker)
	add_button_group(ShipStats.ShipStatTypes.speed, s_marker)
	add_button_group(ShipStats.ShipStatTypes.fuel_consumption, f_marker)

func add_button_group(type: ShipStats.ShipStatTypes, marker: Marker2D):
	var button_group: StatAllocationButtonGroup = button_group_scene.instantiate()
	button_groups.append(button_group)
	button_group.global_position = marker.global_position
	add_child(button_group)
	button_group.initialize(type, refresh_polygon)

func draw_bg_pentagons():
	for i in range(1, inner_line_count + 1):
		var new_polygon = Line2D.new()
		
		# Styling
		new_polygon.width *= 0.5
		new_polygon.default_color = Color("50b347")
		if i != inner_line_count:
			new_polygon.default_color.a = 0.5
		
		var vertex_array = []
		for j in range(7):
			var vertex = get_point_coords(j, i * (max_stat / inner_line_count))
			vertex_array.append(vertex)
		
		new_polygon.points = PackedVector2Array(vertex_array)
		add_child(new_polygon)


# update

func refresh_polygon():
	stat_points_label.text = "Unused stat points: " + str(ShipStats.get_unused_stat_allocation_points())
	update_buttons()
	draw_stat_web()

func update_buttons():
	for b in button_groups:
		b.update()

func draw_stat_web():
	var vertex_array = []
	
	vertex_array.append(get_point_coords(0, ShipStats.Stats[ShipStats.ShipStatTypes.durability]))
	vertex_array.append(get_point_coords(1, ShipStats.Stats[ShipStats.ShipStatTypes.maneuverability]))
	vertex_array.append(get_point_coords(2, ShipStats.Stats[ShipStats.ShipStatTypes.fuel_consumption]))
	vertex_array.append(get_point_coords(3, ShipStats.Stats[ShipStats.ShipStatTypes.speed]))
	vertex_array.append(get_point_coords(4, ShipStats.Stats[ShipStats.ShipStatTypes.radiation_protection]))
	
	stat_polygon.polygon = PackedVector2Array(vertex_array)


# aux
func get_point_coords(point_number, radius):
	return Vector2.from_angle(angle * point_number - PI/2) * min_radius * radius
