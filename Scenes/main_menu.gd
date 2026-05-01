extends Node2D

var location_id: NpcScheduler.locations = NpcScheduler.locations.MAIN_MENU
func _ready() -> void:
	Globals.current_location = NpcScheduler.locations.MAIN_MENU

func _on_startgame_button_up() -> void:
	SceneController.goto_scene("res://Scenes/Prologue/prologue.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		SceneController.goto_scene("res://Scenes/Luner_system/2d/test2d.tscn")


func _on_exit_button_up() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	pass # Replace with function body.


func _on_option_button_up() -> void:
	var option_scene = load("res://Scenes/Misc/options.tscn")
	var option_scene_instance = option_scene.instantiate()
	add_child(option_scene_instance)
	pass # Replace with function body.
