extends Node2D

func _ready() -> void:
	Globals.current_location = NpcScheduler.locations.MAIN_MENU

func _on_startgame_button_up() -> void:
	SceneController.goto_scene("res://Scenes/Prologue/prologue.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		SceneController.goto_scene("res://Scenes/Luner_system/2d/test2d.tscn")
	
