extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.MAIN_MENU
func _ready() -> void:
	Globals.current_location = NpcScheduler.locations.MAIN_MENU

func _on_startgame_button_up() -> void:
	SceneController.goto_scene("res://Scenes/Prologue/prologue.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		SceneController.goto_scene("res://Scenes/Luner_system/2d/test2d.tscn")
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior

func _on_button_2_button_up() -> void:
	get_tree().set_auto_accept_quit(false)
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	# EXIT THE GAME
