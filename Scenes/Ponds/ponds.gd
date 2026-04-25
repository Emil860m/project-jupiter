extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.PONS

@export var scene_to_load: String
@export_category('TimeCosts')
@export var repair_time: int
@export var refuel_time: int
@export var fuel_upgrade_time: int
@export var poj_upgrade_time: int

@export var fuel_upgrade_val: int
@export var poj_upgrade_val: int

@onready var timer: Timer = $Timer

@onready var upgrade_label: Label = $UpgradeMenu/UpgradeLabel
@onready var main_label: Label = $MainMenu/MainLabel

@onready var main_menu: CanvasLayer = $MainMenu
@onready var upgrade_menu: CanvasLayer = $UpgradeMenu

@onready var fuel_upgrade_button = $UpgradeMenu/FuelUpgrade
@onready var poj_upgrade_button = $UpgradeMenu/StatAllocationUpgrade


func _ready() -> void:
	main_label.text = ''
	upgrade_label.text = ''
	
	check_upgrades()

func check_upgrades():
	poj_upgrade_button.disabled = Flags.get_flag("HasPOJUpgrade1")
	fuel_upgrade_button.disabled = Flags.get_flag("HasFuelUpgrade1")

func _on_leave_button_up() -> void:
	ShipStats.damage = 10
	if ShipStats.fuel <= 0:
		main_label.text = 'Your fuel is to low to travel. Please refuel your ship'
		timer.start(1.5)
		return
	if ShipStats.damage >= 10:
		main_label.text = 'Your ship is to damaged to travel. Please repair your ship'
		timer.start(1.5)
		return
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
	ShipStats.upgrade_fuel_cap(fuel_upgrade_val)
	Flags.set_flag("HasFuelUpgrade1")
	upgrade_label.text = 'Fuel capacity increased'
	timer.start(1.5)
	
	check_upgrades()


func _on_stat_allocation_upgrade_button_up() -> void:
	ShipStats.upgrade_poj(poj_upgrade_val)
	Flags.set_flag("HasPOJUpgrade1")
	upgrade_label.text = 'POJ increased'
	timer.start(1.5)
	
	check_upgrades()
