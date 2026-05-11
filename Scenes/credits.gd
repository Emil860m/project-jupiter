extends Node2D

@onready var text := $CanvasLayer/RichTextLabel
var location_id := NpcScheduler.locations.MAIN_MENU
func _on_mainmenu_button_up() -> void:
	SceneController.goto_scene("res://Scenes/MainMenu.tscn")


func _process(delta: float) -> void:
	text.global_position.y -= delta * 100
	if text.global_position.y < -1000:
		text.global_position.y = 1000
