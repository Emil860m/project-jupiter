extends Node

func get_current_scene_path() -> String:
	# Always return a valid path; updates cache when possible
	var s = get_tree().current_scene
	if s:
		return s.scene_file_path
	return ""

func get_tow_trucked():
	goto_scene("res://Scenes/Luner_system/2d/tow_truck.tscn")

func reload_scene():
	# Avoid reload_current_scene(); it can leave current_scene transiently invalid.
	goto_scene(get_current_scene_path())

func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)
	


func _deferred_goto_scene(path):
	var old = get_tree().current_scene
	var s = ResourceLoader.load(path)
	var inst = s.instantiate()
	Globals.current_location = inst.location_id

	get_tree().root.add_child(inst)
	get_tree().current_scene = inst

	if is_instance_valid(old):
		old.queue_free()
