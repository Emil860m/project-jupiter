extends Node2D


var selected: Area2D
@export var camera_2d: Camera2D
@onready var input_comp: input_component = $InputComponent
@onready var raycast_comp: raycast_2d_component = $Raycast2dComponent
@onready var moons: Node2D = $MoonParent
@onready var statPointPopup: Sprite2D = $UiElements/statPointPopup
@export var selectedMoonLabel: Label
@export var currentLocationLabel: Label
@export var estimatedTravelLabel: Label
@export var estimatedFuelLabel: Label
@export var shipStatusLabel: Label
@export var shipsDeltaV: Label
@export var shipsMaxDeltaV: Label
@export var hourLabel: Label
@export var noice_max = 15.0
@export var noice_min = 5.0
var current_location: moon_2d
@onready var button: Button = $UiElements/Button

var event_scene := preload("res://Scenes/Luner_system/2d/event_display.tscn")

var traveltime_noice = 0
var fuel_noice = 0

func _ready() -> void:
	var travel_positive_noice = 1 == randi_range(0,1)
	var fuel_positive_noice = 1 == randi_range(0,1)
	traveltime_noice = randf_range(noice_min, noice_max) * (1 if travel_positive_noice else -1)
	fuel_noice = randf_range(noice_min, noice_max) * (1 if fuel_positive_noice else -1)
	shipStatusLabel.text = str(10 - ShipStats.damage)
	shipsDeltaV.text = str(float(ShipStats.fuel))
	shipsMaxDeltaV.text = "/ " + str(float(ShipStats.fuel_cap))
	hourLabel.text = Globals.convert_timesteps_to_string(Globals.current_timestep)
	Globals.current_location = NpcScheduler.locations.PLANET_VIEW
	
	raycast_comp.camera_2d = camera_2d
	current_location = get_node("MoonParent/" + Globals.current_moon)
	currentLocationLabel.text = current_location.displayName
	var current_location_vector = current_location.global_position
	current_location.youAreHere.visible = true
	for m in moons.get_children():
		m.planetview = self
		for i in range(Globals.max_travel_distance):
			if current_location_vector.distance_to(m.get_position_at_time(Globals.current_timestep + i)) <= ShipStats.travel_speed * i:
				#m.set_estimated_loc(i, current_location_vector)
				m.base_travel_time = (i + pow(ShipStats.severity_const, ShipStats.damage))
				m.estimated_travel_time = m.base_travel_time / (0.1 * ShipStats.Stats[ShipStats.ShipStatTypes.speed]) 
				break

func select_moon(hit):
	button.disabled = false
	if hit == null:
		return
	if hit == current_location:
		return
	if selected != null:
		selected.set_selected(false)
		selectedMoonLabel.text = "None"
	if hit.is_in_group("moon"):
		selected = hit
		selected.set_selected(true)
		selectedMoonLabel.text = hit.displayName
		update_travel_time()

func update_travel_time() -> void:
	if selected == null:
		return
	selected.estimated_travel_time = selected.base_travel_time / (0.1 * ShipStats.Stats[ShipStats.ShipStatTypes.speed]) 
	var estimated_fuel = selected.base_travel_time / (0.1 * ShipStats.Stats[ShipStats.ShipStatTypes.fuel_consumption]) 
	estimatedTravelLabel.text = Globals.convert_timesteps_to_string(round(selected.estimated_travel_time * (1 + traveltime_noice / 100)) + Globals.current_timestep)
	estimatedFuelLabel.text = str(round(estimated_fuel * (1 + fuel_noice / 100)))
	for m in moons.get_children():
			m.set_estimated_loc(selected.estimated_travel_time, current_location.global_position)


func _on_travel_button_up() -> void:
	if selected:
		if ShipStats.get_unused_stat_allocation_points() > 0:
			statPointPopup.visible = true
			return
		Globals.increment_timestep(selected.estimated_travel_time)
		ShipStats.spend_fuel(selected.base_travel_time)
		Globals.current_moon = selected.name
		if selected.travelScenePath:
			SoundController.set_in_flight(true)
			var event = event_scene.instantiate()
			event.set_completion_callback(_on_event_completed)
			add_child(event)
			event.start(
				Globals.current_timestep,
				Globals.current_timestep + selected.estimated_travel_time,
				current_location.global_position,
				selected.estimated_loc.global_position)
		else:
			SceneController.reload_scene()


func _on_exit_button_up() -> void:
	if not Globals.current_moon == "OutPost":
		SceneController.goto_scene(current_location.travelScenePath)

func _on_event_completed() -> void:
	SceneController.goto_scene(selected.travelScenePath)


func _on_stat_allocator_change_stat() -> void:
	update_travel_time()
	pass # Replace with function body.


func _on_statpointPopup_button_up() -> void:
	statPointPopup.visible = false
	pass # Replace with function body.
