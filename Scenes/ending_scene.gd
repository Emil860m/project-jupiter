extends Node2D

var location_id:= NpcScheduler.locations.ENDING
var message := ""
@onready var label := $CanvasLayer/Label

func _ready() -> void:
	label.text = message

func _on_mainmenu_button_up() -> void:
	SceneController.goto_scene("res://Scenes/MainMenu.tscn")


func _on_quit_button_up() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
