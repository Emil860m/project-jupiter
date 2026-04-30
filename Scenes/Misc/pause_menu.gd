extends Node2D

@onready var background: TextureRect = $CanvasLayer/Background
@onready var center_container: CenterContainer = $CanvasLayer/CenterContainer
@onready var slider_container: VBoxContainer = $CanvasLayer/CenterContainer/VBoxContainer

@onready var master_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/MasterContainer/MasterSlider
@onready var bgm_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/BgmContainer/BgmSlider
@onready var sfx_slider: HSlider = $CanvasLayer/CenterContainer/VBoxContainer/SfxContainer/SfxSlider


var max_val: float = 10

func _ready() -> void:
	background.size = get_viewport_rect().size * 0.75
	background.modulate.a = 0.5
	center_container.custom_minimum_size = get_viewport_rect().size
	slider_container.custom_minimum_size = get_viewport_rect().size / 4
	
	master_slider.value = SoundController.master_vol * 10
	bgm_slider.value = SoundController.music_vol * 10
	sfx_slider.value = SoundController.sound_vol * 10


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_resume_button_button_up()
	pass


func _on_master_slider_value_changed(value: float) -> void:
	SoundController.master_vol = value / max_val


func _on_bgm_slider_value_changed(value: float) -> void:
	SoundController.music_vol = value / max_val


func _on_sfx_slider_value_changed(value: float) -> void:
	SoundController.sound_vol = value / max_val

func _on_resume_button_button_up() -> void:
	get_tree().paused = false
	queue_free()


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	SoundController.play_mid_boop()
	pass # Replace with function body.
