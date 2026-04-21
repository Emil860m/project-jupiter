extends Node

var flags: Dictionary = {}

func set_flag(flag: String, value = true) -> void:
	if flag in flags:
		print("setting a flag that has already been set")
	else:
		flags[flag] = value

func get_flag(flag: String) -> bool:
	return flags.get_or_add(flag, false)
