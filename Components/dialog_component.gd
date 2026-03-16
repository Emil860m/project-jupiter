extends Node


@export var filename: String

func _ready(): 
	var json_dict = FileHandling.get_json(filename)
	print(json_dict)
	
	
	
