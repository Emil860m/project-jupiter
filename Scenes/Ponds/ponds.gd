extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.PONS

@export var scene_to_load: String
@export_category('TimeCosts')
@export var repair_time: int
@export var refuel_time: int
@export var fuel_upgrade_time: int
@export var poj_upgrade_time: int
@export var noise_reduction_time: int

@export var fuel_upgrade_val: int
@export var poj_upgrade_val: int

@onready var timer: Timer = $Timer

@onready var upgrade_label: Label = $UpgradeMenu/UpgradeLabel
@onready var main_label: Label = $MainMenu/MainLabel

@onready var main_menu: CanvasLayer = $MainMenu
@onready var upgrade_menu: CanvasLayer = $UpgradeMenu
@onready var _animated_sprite_1 = $Background/BCG1
@onready var _animated_sprite_2 = $Background/BCG2
@onready var _animated_sprite_3 = $Background/BCG3
@onready var _animated_sprite_4 = $Background/BCG4

@onready var fuel_upgrade_button = $UpgradeMenu/FuelUpgrade
@onready var poj_upgrade_button = $UpgradeMenu/StatAllocationUpgrade
@onready var noise_reduction_button = $UpgradeMenu/NoiseReduction
@onready var repair_button: Button = $MainMenu/RepairButton
@onready var refuel_button: Button = $MainMenu/RefuelButton


@onready var dialog_component = $DialogComponent
@onready var time_label = $Background/time_label
@export var miko_portrait_path := ""



func _ready() -> void:
	main_label.text = ''
	upgrade_label.text = ''
	_animated_sprite_1.play("default")
	_animated_sprite_2.play("default")
	_animated_sprite_3.play("default")
	_animated_sprite_4.play("default")
	check_upgrades()
	
	if not Flags.get_flag("PonsTutorialComplete"):
		Flags.set_flag("PonsTutorialComplete")
		if miko_portrait_path != "":
			dialog_component.set_character_portrait(miko_portrait_path)
		dialog_component.start_dialog()

func check_upgrades():
	time_label.text = Globals.convert_timesteps_to_string(Globals.current_timestep)
	refuel_button.disabled = ShipStats.fuel == ShipStats.fuel_cap
	repair_button.disabled = ShipStats.damage == 0
	poj_upgrade_button.disabled = Flags.get_flag("HasPOJUpgrade1")
	fuel_upgrade_button.disabled = Flags.get_flag("HasFuelUpgrade1")
	noise_reduction_button.disabled = Flags.get_flag("HasNoiseReduction1")

func _on_leave_button_up() -> void:
	SoundController.play_low_boop()
	if Globals.interacting:
		return
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
	SoundController.play_high_boop()
	if Globals.interacting:
		return
	main_label.text = 'Your ship has been refueled'
	timer.start(1.5)
	ShipStats.refuel()
	Globals.increment_timestep(refuel_time)
	check_upgrades()


func _on_repair_button_button_up() -> void:
	SoundController.play_high_boop()
	if Globals.interacting:
		return
	main_label.text = 'Your ship has been repaired'
	timer.start(1.5)
	ShipStats.repair()
	Globals.increment_timestep(repair_time)
	check_upgrades()


func _on_timer_timeout() -> void:
	main_label.text = ''
	upgrade_label.text = ''


func _on_upgrade_button_button_up() -> void:
	SoundController.play_mid_boop()
	if Globals.interacting:
		return
	upgrade_menu.visible = true
	main_menu.visible = false
	_animated_sprite_1.visible = false
	_animated_sprite_2.visible = false
	_animated_sprite_3.visible = true
	_animated_sprite_4.visible = true


func _on_back_button_button_up() -> void:
	SoundController.play_mid_boop()
	main_menu.visible = true
	upgrade_menu.visible = false
	_animated_sprite_1.visible = true
	_animated_sprite_2.visible = true
	_animated_sprite_3.visible = false
	_animated_sprite_4.visible = false


func _on_fuel_upgrade_button_up() -> void:
	SoundController.play_high_boop()
	ShipStats.upgrade_fuel_cap(fuel_upgrade_val)
	Flags.set_flag("HasFuelUpgrade1")
	upgrade_label.text = 'Fuel capacity increased'
	timer.start(1.5)
	
	Globals.increment_timestep(fuel_upgrade_time)
	check_upgrades()


func _on_stat_allocation_upgrade_button_up() -> void:
	SoundController.play_high_boop()
	ShipStats.upgrade_poj(poj_upgrade_val)
	Flags.set_flag("HasPOJUpgrade1")
	upgrade_label.text = 'POJ increased'
	timer.start(1.5)
	
	Globals.increment_timestep(poj_upgrade_time)
	check_upgrades()


func _on_noise_reduction_button_up() -> void:
	SoundController.play_high_boop()
	ShipStats.reduce_noise()
	Flags.set_flag("HasNoiseReduction1")
	upgrade_label.text = 'Estimation noise reduced'
	timer.start(1.5)
	
	Globals.increment_timestep(noise_reduction_time)
	check_upgrades()
