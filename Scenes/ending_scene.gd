extends Node2D

var location_id:= NpcScheduler.locations.ENDING
var message := ""
var ch3: bool
@onready var label := $CanvasLayer/Label
@onready var chapterTrans = $ChapterTransition
func _ready() -> void:
	if ch3:
		await chapterTrans.transition_finished
	else:
		chapterTrans.visible = false
	label.text = message
	$CanvasLayer.visible = true
func _on_mainmenu_button_up() -> void:
	SceneController.goto_scene("res://Scenes/MainMenu.tscn")


func _on_quit_button_up() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
