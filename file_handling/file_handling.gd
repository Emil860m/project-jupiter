extends Node


func get_json(file_name: String):
	var file_contents = FileAccess.get_file_as_string("res://file_handling/" + file_name)
	var json_dict = JSON.parse_string(file_contents)
	if json_dict:
		return json_dict
	return {}
