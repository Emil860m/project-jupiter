extends Node2D

@onready var text := $CanvasLayer/Control
var location_id := NpcScheduler.locations.MAIN_MENU
func _on_mainmenu_button_up() -> void:
	SceneController.goto_scene("res://Scenes/MainMenu.tscn")


func _process(delta: float) -> void:
	text.global_position.y -= delta * 100
	if text.global_position.y < -3500:
		text.global_position.y = 0
