extends Node

var should_tow_truck = false

func get_current_scene_path() -> String:
	# Always return a valid path; updates cache when possible
	var s = get_tree().current_scene
	if s:
		return s.scene_file_path
	return ""

func _get_tow_trucked():
	goto_scene("res://Scenes/Luner_system/2d/tow_truck.tscn")

func reload_scene():
	# Avoid reload_current_scene(); it can leave current_scene transiently invalid.
	goto_scene(get_current_scene_path())

func goto_ending_scene(message: String):
	_deferred_goto_ending_scene.call_deferred(message)
	
func _deferred_goto_ending_scene(message: String):
	var old = get_tree().current_scene
	var s = ResourceLoader.load("res://Scenes/EndingScene.tscn")
	var inst = s.instantiate()
	inst.message = message
	Globals.current_location = inst.location_id

	get_tree().root.add_child(inst)
	get_tree().current_scene = inst

	if is_instance_valid(old):
		old.queue_free()

func goto_scene(path):
	if should_tow_truck:
		should_tow_truck = false
		_get_tow_trucked()
	else:
		_deferred_goto_scene.call_deferred(path)
	
func goto_loading_screen(path_to_next_scene, path_to_poster, other_poster_paths: Array[String]):
	if should_tow_truck:
		should_tow_truck = false
		_get_tow_trucked()
	else:
		var old = get_tree().current_scene
		var s = ResourceLoader.load("res://SceneTransitions/loading_scene.tscn")
		var inst = s.instantiate()
		inst.next_scene = path_to_next_scene
		inst.poster = path_to_poster
		inst.other_posters = other_poster_paths
		Globals.current_location = inst.location_id

		get_tree().root.add_child(inst)
		get_tree().current_scene = inst

		if is_instance_valid(old):
			old.queue_free()

func _deferred_goto_scene(path):
	var old = get_tree().current_scene
	var s = ResourceLoader.load(path)
	var inst = s.instantiate()
	Globals.current_location = inst.location_id

	get_tree().root.add_child(inst)
	get_tree().current_scene = inst

	if is_instance_valid(old):
		old.queue_free()


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior
