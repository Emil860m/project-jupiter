extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.PONS

@export var scene_to_load: String
@export_category('TimeCosts')
@export var repair_time: int
@export var refuel_time: int
@export var fuel_upgrade_time: int

@onready var timer: Timer = $Timer

@onready var upgrade_label: Label = $UpgradeMenu/UpgradeLabel
@onready var main_label: Label = $MainMenu/MainLabel

@onready var main_menu: CanvasLayer = $MainMenu
@onready var upgrade_menu: CanvasLayer = $UpgradeMenu

func _ready() -> void:
	main_label.text = ''
	upgrade_label.text = ''

func _on_leave_button_up() -> void:
	SceneController.goto_scene(scene_to_load)


func _on_refuel_button_button_up() -> void:
	main_label.text = 'Your ship has been refueled'
	timer.start(1.5)
	ShipStats.refuel()
	Globals.increment_timestep(refuel_time)


func _on_repair_button_button_up() -> void:
	main_label.text = 'Your ship has been repaired'
	timer.start(1.5)
	ShipStats.repair()
	Globals.increment_timestep(repair_time)


func _on_timer_timeout() -> void:
	main_label.text = ''
	upgrade_label.text = ''


func _on_upgrade_button_button_up() -> void:
	upgrade_menu.visible = true
	main_menu.visible = false


func _on_back_button_button_up() -> void:
	main_menu.visible = true
	upgrade_menu.visible = false


func _on_fuel_upgrade_button_up() -> void:
	upgrade_label.text = 'Fuel capacity increased'
	timer.start(1.5)
	ShipStats.upgrade_fuel_cap()
