extends Node2D

var location_id:= NpcScheduler.locations.ENDING
var message := "Thanks for playing!"
var ch3: bool
@onready var label := $CanvasLayer/Label
@onready var label2 := $CanvasLayer/Label2
@onready var chapterTrans = $ChapterTransition
func _ready() -> void:
	label.text = message
	label2.text = check_flags()
	if ch3:
		await chapterTrans.transition_finished
	else:
		chapterTrans.visible = false
	$CanvasLayer.visible = true
func _on_mainmenu_button_up() -> void:
	SceneController.goto_scene("res://Scenes/credits.tscn")


func _on_quit_button_up() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


func check_flags() -> String:
	var recruitedString = ""
	if Flags.get_flag("hickRecruit"):
		recruitedString += "Hickey "
		if Flags.get_flag("sullyRecruit"):
			recruitedString += "and Sully "
	elif Flags.get_flag("sullyRecruit"):
		recruitedString += "Sully "
	else:
		recruitedString += "0 people "
	return "You recruited " + recruitedString + "to the funeral!"
