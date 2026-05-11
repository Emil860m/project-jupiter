extends Node2D

@onready var center_container: CenterContainer = $CanvasLayer/CenterContainer
@onready var slider_container: VBoxContainer = $CanvasLayer/CenterContainer/VBoxContainer

@onready var master_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/MasterContainer/MasterSlider
@onready var bgm_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/BgmContainer/BgmSlider
@onready var sfx_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/SfxContainer/SfxSlider


var max_val: float = 10

func _ready():
	center_container.custom_minimum_size = get_viewport_rect().size
	slider_container.custom_minimum_size = get_viewport_rect().size / 4
	
	master_slider.value = SoundController.master_vol * 10
	bgm_slider.value = SoundController.music_vol * 10
	sfx_slider.value = SoundController.sound_vol * 10


func _on_master_slider_value_changed(value: float) -> void:
	SoundController.master_vol = value / max_val


func _on_bgm_slider_value_changed(value: float) -> void:
	SoundController.music_vol = value / max_val


func _on_sfx_slider_value_changed(value: float) -> void:
	SoundController.sound_vol = value / max_val


func _on_exit_button_pressed() -> void:
	queue_free()
	return
	


func _on_credits_button_up() -> void:
	SceneController.goto_scene("res://Scenes/credits.tscn")
