extends Node2D

@onready var dialogComp = $DialogComponent
@onready var dialogRunner = $DialogComponent/DialogRunner


func _ready() -> void:
	dialogRunner.connect("dialogue_completed", on_dialogue_completed)
	
func on_dialogue_completed():
	SceneController.goto_scene("res://Scenes/Luner_system/2d/test2d.tscn")
