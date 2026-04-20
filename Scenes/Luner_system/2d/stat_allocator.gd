extends Node2D

@onready var stat_polygon := $StatPolygon
@onready var stat_points_label := $StatPointsLabel

var max_stat: float = ShipStats.max_allowed_stat
var angle = 2*PI/5
var max_radius = 200
var min_radius = max_radius / max_stat

var inner_line_count = 5

func _ready() -> void:
	for i in range(1, inner_line_count + 1):
		var new_polygon = Line2D.new()
		
		# Styling
		new_polygon.width *= 0.5
		new_polygon.default_color = Color.WEB_GREEN
		if i != inner_line_count:
			new_polygon.default_color.a = 0.5
		
		var vertex_array = []
		for j in range(7):
			var vertex = get_point_coords(j, i * (max_stat / inner_line_count))
			vertex_array.append(vertex)
		
		new_polygon.points = PackedVector2Array(vertex_array)
		add_child(new_polygon)
	
	
	# Styling stat web
	stat_polygon.color = Color.GREEN
	stat_polygon.color.a = 0.5
	refresh_polygon()

func refresh_polygon():
	stat_points_label.text = "Unused stat points: " + str(ShipStats.get_unused_stat_allocation_points())
	draw_stat_web()

func draw_stat_web():
	var vertex_array = []
	
	vertex_array.append(get_point_coords(0, ShipStats.Stats[ShipStats.ShipStatTypes.durability]))
	vertex_array.append(get_point_coords(1, ShipStats.Stats[ShipStats.ShipStatTypes.maneuverability]))
	vertex_array.append(get_point_coords(2, ShipStats.Stats[ShipStats.ShipStatTypes.fuel_consumption]))
	vertex_array.append(get_point_coords(3, ShipStats.Stats[ShipStats.ShipStatTypes.speed]))
	vertex_array.append(get_point_coords(4, ShipStats.Stats[ShipStats.ShipStatTypes.radiation_protection]))
	
	stat_polygon.polygon = PackedVector2Array(vertex_array)

func get_point_coords(point_number, radius):
	return Vector2.from_angle(angle * point_number - PI/2) * min_radius * radius


# Signals
func _on_r_allocate_button_pressed():
	ShipStats.allocate_stat(ShipStats.ShipStatTypes.radiation_protection)
	refresh_polygon()

func _on_r_de_allocate_button_pressed():
	ShipStats.de_allocate_stat(ShipStats.ShipStatTypes.radiation_protection)
	refresh_polygon()


func _on_d_allocate_button_pressed():
	ShipStats.allocate_stat(ShipStats.ShipStatTypes.durability)
	refresh_polygon()

func _on_d_de_allocate_button_pressed():
	ShipStats.de_allocate_stat(ShipStats.ShipStatTypes.durability)
	refresh_polygon()


func _on_m_allocate_button_pressed():
	ShipStats.allocate_stat(ShipStats.ShipStatTypes.maneuverability)
	refresh_polygon()

func _on_m_de_allocate_button_pressed():
	ShipStats.de_allocate_stat(ShipStats.ShipStatTypes.maneuverability)
	refresh_polygon()


func _on_s_allocate_button_pressed():
	ShipStats.allocate_stat(ShipStats.ShipStatTypes.speed)
	refresh_polygon()

func _on_s_de_allocate_button_pressed():
	ShipStats.de_allocate_stat(ShipStats.ShipStatTypes.speed)
	refresh_polygon()


func _on_f_allocate_button_pressed():
	ShipStats.allocate_stat(ShipStats.ShipStatTypes.fuel_consumption)
	refresh_polygon()

func _on_f_de_allocate_button_pressed():
	ShipStats.de_allocate_stat(ShipStats.ShipStatTypes.fuel_consumption)
	refresh_polygon()
