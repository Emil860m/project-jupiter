extends Node

var flags: Dictionary = {}

func set_flag(flag: String, value = true) -> void:
	flags[flag] = value

func get_flag(flag: String) -> bool:
	return flags.get_or_add(flag, false)
