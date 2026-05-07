extends Node


var hickey: Dictionary[locations, Array]
var kass: Dictionary[locations, Array]
var zoe: Dictionary[locations, Array]
var sally: Dictionary[locations, Array]

var consoles: Dictionary[locations, Array]
var boxes: Dictionary[locations, Array]

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
		locations.HOSPITAL: [
			NPC_Schedule.new(td2ts(20, 0), td2ts(25, 0), ["hickHospital"],[], "hickHospitalTS6")
		],
		locations.WORKSHOP: [
			NPC_Schedule.new(td2ts(11, 00), td2ts(12, 15), [],[], "hickWorkshopTS3"),
			NPC_Schedule.new(td2ts(15, 15), td2ts(18, 00), [],[], "hickWorkshopTS5"),
			NPC_Schedule.new(td2ts(20, 00), td2ts(21, 00), [],["hickHospital"], "hickWorkshopTS6")
		],
		locations.OFFICE: []
	}
	kass = {
		locations.HOSPITAL: [
			NPC_Schedule.new(td2ts(9, 00), td2ts(14, 00), [],[], "kasHospitalTS1"),
			NPC_Schedule.new(td2ts(14, 01), td2ts(20, 00), [],["kassWorkshop"],"kasHospitalTS4"),
			NPC_Schedule.new(td2ts(18, 00), td2ts(20, 00), [],[],"kasHospitalTS7"),
		],
		locations.WORKSHOP: [
			NPC_Schedule.new(td2ts(16, 30), td2ts(18, 00), ["kassWorkshop"],[],"kasWorkshopTS5")
		]
	}
	zoe = {
		locations.HOSPITAL: [
			NPC_Schedule.new(td2ts(12, 45), td2ts(14, 00), ["zoeHospital"],[],"zoeHospitalTS4"),
			],
		locations.OFFICE: [
			NPC_Schedule.new(td2ts(9, 00), td2ts(16, 00), [],["sullyOffice"],"zoeOfficeTS2"),
			NPC_Schedule.new(td2ts(9, 00), td2ts(12, 30), ["sullyOffice"],[],"SalOfficeTS3"),
			NPC_Schedule.new(td2ts(12, 45), td2ts(16, 00), [],["zoeHospital"],"zoeOfficeTS5"),
			NPC_Schedule.new(td2ts(16, 01), td2ts(20, 00), [],[],"zoeOfficeTS5"),
		]
	}
	sally = {
		locations.HOSPITAL: [
			NPC_Schedule.new(td2ts(11, 45), td2ts(18, 00), [],["sullyOffice"],"SalHospitalTS2"),
			NPC_Schedule.new(td2ts(12, 45), td2ts(21, 00), ["sullyOffice"],[],"SalHospitalTS4"),
		],
		locations.WORKSHOP: [
			NPC_Schedule.new(td2ts(9, 00), td2ts(11, 30), [],[],"SalWorkshopTS1"),
			NPC_Schedule.new(td2ts(18, 30), td2ts(23, 30), [],["sullyOffice"],"SalWorkshopTS6"),
			NPC_Schedule.new(td2ts(21, 30), td2ts(25, 00), ["sullyOffice"],[],"SalWorkshopTS6"),
		],
		locations.OFFICE: [
			NPC_Schedule.new(td2ts(9, 00), td2ts(12, 30), ["sullyOffice"],[],"SalOfficeTS3"),
		]
	}
	consoles = {
		locations.HOSPITAL: [
			NPC_Schedule.new(td2ts(7, 40), td2ts(9, 0), [],[],"console_0740to0900"),
			NPC_Schedule.new(td2ts(9, 0), td2ts(10, 0), [],[],"console_0900to1000"),
			NPC_Schedule.new(td2ts(10, 0), td2ts(11, 0), [],[],"console_1000to1100"),
			NPC_Schedule.new(td2ts(11, 0), td2ts(12, 0), [],[],"console_1100to1200"),
			NPC_Schedule.new(td2ts(12, 0), td2ts(13, 0), [],[],"console_1200to1300"),
			NPC_Schedule.new(td2ts(13, 0), td2ts(14, 0), [],[],"console_1300to1400"),
			NPC_Schedule.new(td2ts(14, 0), td2ts(15, 0), [],[],"console_1400to1500"),
			NPC_Schedule.new(td2ts(15, 0), td2ts(16, 0), [],[],"console_1500to1600"),
			NPC_Schedule.new(td2ts(16, 0), td2ts(17, 0), [],[],"console_1600to1700"),
			NPC_Schedule.new(td2ts(17, 0), td2ts(18, 0), [],[],"console_1700to1800"),
			NPC_Schedule.new(td2ts(18, 0), td2ts(19, 0), [],[],"console_1800to1900"),
			NPC_Schedule.new(td2ts(19, 0), td2ts(20, 0), [],[],"console_1900to2000"),
			NPC_Schedule.new(td2ts(20, 0), td2ts(21, 0), [],[],"console_2000to2100"),
			NPC_Schedule.new(td2ts(21, 0), td2ts(22, 0), [],[],"console_2100to2200"),
			NPC_Schedule.new(td2ts(22, 0), td2ts(23, 0), [],[],"console_2200to2300"),
			NPC_Schedule.new(td2ts(23, 0), td2ts(24, 0), [],[],"console_2300to2400"),
			NPC_Schedule.new(td2ts(24, 0), td2ts(25, 0), [],[],"console_2400to2500"),
		],
		locations.WORKSHOP: [
			NPC_Schedule.new(td2ts(7, 40), td2ts(9, 0), [],[],"console_0740to0900"),
			NPC_Schedule.new(td2ts(9, 0), td2ts(10, 0), [],[],"console_0900to1000"),
			NPC_Schedule.new(td2ts(10, 0), td2ts(11, 0), [],[],"console_1000to1100"),
			NPC_Schedule.new(td2ts(11, 0), td2ts(12, 0), [],[],"console_1100to1200"),
			NPC_Schedule.new(td2ts(12, 0), td2ts(13, 0), [],[],"console_1200to1300"),
			NPC_Schedule.new(td2ts(13, 0), td2ts(14, 0), [],[],"console_1300to1400"),
			NPC_Schedule.new(td2ts(14, 0), td2ts(15, 0), [],[],"console_1400to1500"),
			NPC_Schedule.new(td2ts(15, 0), td2ts(16, 0), [],[],"console_1500to1600"),
			NPC_Schedule.new(td2ts(16, 0), td2ts(17, 0), [],[],"console_1600to1700"),
			NPC_Schedule.new(td2ts(17, 0), td2ts(18, 0), [],[],"console_1700to1800"),
			NPC_Schedule.new(td2ts(18, 0), td2ts(19, 0), [],[],"console_1800to1900"),
			NPC_Schedule.new(td2ts(19, 0), td2ts(20, 0), [],[],"console_1900to2000"),
			NPC_Schedule.new(td2ts(20, 0), td2ts(21, 0), [],[],"console_2000to2100"),
			NPC_Schedule.new(td2ts(21, 0), td2ts(22, 0), [],[],"console_2100to2200"),
			NPC_Schedule.new(td2ts(22, 0), td2ts(23, 0), [],[],"console_2200to2300"),
			NPC_Schedule.new(td2ts(23, 0), td2ts(24, 0), [],[],"console_2300to2400"),
			NPC_Schedule.new(td2ts(24, 0), td2ts(25, 0), [],[],"console_2400to2500"),
		]
		# add more schedules here
	}
	boxes = {
		locations.HOSPITAL: [],
		locations.WORKSHOP: [
			NPC_Schedule.new(td2ts(15, 00), td2ts(25, 00), [],[],"box"),

		]
		# add schedules here
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
	
func get_consoles_yarn_file(current_timestep: int, location: locations):
	for event in consoles[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	
func get_boxes_yarn_file(current_timestep: int, location: locations):
	for event in boxes[location]:
		if event.check_valid(current_timestep):
			return event.get_yarn_node()
	return ""
	

# Time of day to in game timestep
func td2ts(hours: int, mins: int):
	var minutes: float = mins + 60 * hours
	return floor((minutes - Globals.minutes_before_timestep_zero) / Globals.minutes_per_timestep) 
