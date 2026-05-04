extends Node

class_name NPC_Schedule

var start_time: int
var end_time: int
var flags: Array[String]
var reverse_flags: Array[String]
var yarn_node: String
var location: String

func _init(start, end, flag_list: Array[String], reverse_flag_list: Array[String], yarn) -> void:
	start_time = start
	end_time = end
	flags = flag_list
	reverse_flags = reverse_flag_list
	yarn_node = yarn



func get_yarn_node():
	return yarn_node

func check_valid(current_timestep):
	if current_timestep >= start_time and current_timestep <= end_time:
		for flag in flags:
			if not Flags.get_flag(flag):
				return false
		for flag in reverse_flags:
			if Flags.get_flag(flag):
				return false
		return true
	return false
