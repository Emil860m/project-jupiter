extends Node2D

@onready var dialogComp = $DialogComponent
@onready var dialogRunner = $DialogComponent/DialogRunner


func _ready() -> void:
	dialogRunner.connect("dialogue_completed", on_dialogue_completed)
	
func on_dialogue_completed():
	SceneController.goto_scene("res://Scenes/Hospital/Hospital2.tscn")
