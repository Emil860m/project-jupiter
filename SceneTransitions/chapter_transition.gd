extends Node2D

signal transition_finished

@onready var container: CenterContainer = $CenterContainer
@onready var bg: ColorRect = $CenterContainer/Background
@onready var fade: ColorRect = $CenterContainer/Fade

@onready var chapter_label: Label = $CenterContainer/VBoxContainer/Chapter
@onready var title_label: Label = $CenterContainer/VBoxContainer/Title

@export var fade_in_time: float = 3.0
@export var fade_out_time: float = 2.0


func _ready() -> void:
	container.custom_minimum_size = get_viewport_rect().size
	bg.custom_minimum_size = get_viewport_rect().size
	fade.custom_minimum_size = get_viewport_rect().size
	
	chapter_label.text = "CHAPTER " + str(Globals.current_chapter)
	title_label.text = "\n" + Globals.get_current_chapter_title()
	
	# Fade in
	var tween = get_tree().create_tween()
	await tween.tween_property(fade, "modulate", Color.TRANSPARENT, fade_in_time).finished


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_confirm"):
		# Fade out
		var tween = get_tree().create_tween()
		await tween.tween_property(fade, "modulate", Color.BLACK, fade_out_time).finished
		
		transition_finished.emit()
		queue_free()
