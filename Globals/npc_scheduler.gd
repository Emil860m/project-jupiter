extends Node


var hickey: Dictionary[locations, Array]
var kass: Dictionary[locations, Array]
var zoe: Dictionary[locations, Array]
var sally: Dictionary[locations, Array]

enum locations {
	MAIN_MENU,
	PROLOGUE,
	PLANET_VIEW,
	HOSPITAL,
	WORKSHOP,
	OFFICE,
	RATIONALE,
	PONS,
	TOWTRUCK,
	ENDING,
	LOADING
}

func _ready() -> void:
	# Make sure the flag is a callable: a function call without the parenthesis (ask if confused)
	# Make sure that if any timesteps overlap in locations, that the flags are different.
	# Try to make sure that at any time at most 1 schedule can be true. 
	# We do not make checks after finding a valid schedule, we just return that one 
	# the structure is: (start_time, end_time, flags, yarn_node)
	hickey = {
	locations.MAIN_MENU: [],
	locations.PLANET_VIEW: [],
	locations.HOSPITAL: [
		NPC_Schedule.new(0, 100, [], "hickWorkshopTS3"),
		NPC_Schedule.new(45, 52, [], "")
		
	],
	locations.WORKSHOP: [
		NPC_Schedule.new(9, 17, [], "hickWorkshopTS3"),
		NPC_Schedule.new(26, 36, [], "hickWorkshopTS5"),
		NPC_Schedule.new(45, 48, [], ""),
		NPC_Schedule.new(53, 56, [], "")
	]
	}
	kass = {
		
	}
	zoe = {
		
	}
	sally = {
		
	}
	
	
func get_hickey_yarn_file(current_timestep: int, location: locations):
	for event in hickey[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	
func get_kass_yarn_file(current_timestep: int, location: locations):
	for event in kass[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	
func get_zoe_yarn_file(current_timestep: int, location: locations):
	for event in zoe[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	
func get_sally_yarn_file(current_timestep: int, location: locations):
	for event in sally[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	
	
	
	
