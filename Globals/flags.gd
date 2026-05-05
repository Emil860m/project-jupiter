extends Node

var flags: Dictionary = {}

func set_flag(flag: String, value = true) -> void:
	flags[flag] = value

func get_flag(flag: String) -> bool:
	return flags.get_or_add(flag, false)

func get_flag_uncheck(flag: String) -> bool:
	return not get_flag(flag)

func unset_flag(flag: String) -> void:
	set_flag(flag, false)
