extends Node2D


func _on_startgame_button_up() -> void:
	SceneController.goto_scene("res://Scenes/Prologue/prologue.tscn")
