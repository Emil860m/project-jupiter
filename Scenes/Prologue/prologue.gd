extends Node2D

@onready var chapterTrans = $ChapterTransition
@onready var dialogComp = $DialogComponent
@onready var dialogRunner = $DialogComponent/DialogRunner
var location_id: NpcScheduler.locations = NpcScheduler.locations.PROLOGUE

var transition_scene = preload("res://SceneTransitions/chapter_transition.tscn")
@onready var _animated_sprite = $CanvasLayer/AnimatedSprite2D

func _ready() -> void:
	await chapterTrans.transition_finished
	_animated_sprite.play("default")
	
	dialogRunner.connect("dialogue_completed", on_dialogue_completed)
	dialogComp.start_dialog()

func on_dialogue_completed():
	Globals.save_ch1_values()
	Globals.advance_chapter()
	var transition = transition_scene.instantiate()
	add_child(transition)
	await transition.transition_finished
	Globals.interacting = false
	SceneController.goto_scene("res://Scenes/Luner_system/2d/test2d.tscn")
