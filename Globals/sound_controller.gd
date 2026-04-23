extends Node

@onready var bgm_emitter = $BgmEmitter

func _ready():
	bgm_emitter.play()

func set_bgm(location):
	bgm_emitter.set_parameter("Location", get_location_parameter(location))

func set_in_flight(is_in_flight: bool):
	bgm_emitter.set_parameter("inFlight", is_in_flight)

func get_location_parameter(loc: NpcScheduler.locations) -> String:
	if loc != NpcScheduler.locations.PONS and loc != NpcScheduler.locations.RATIONALE:
		set_in_flight(false)
	
	match loc:
		NpcScheduler.locations.MAIN_MENU: return "Title"
		NpcScheduler.locations.PROLOGUE: return "Title" # TODO add prologue music
		NpcScheduler.locations.PLANET_VIEW: return "Travel"
		NpcScheduler.locations.PONS: return "Pons"
		NpcScheduler.locations.RATIONALE: return "Rationale"
		NpcScheduler.locations.WORKSHOP: return "Kallisto"
		NpcScheduler.locations.HOSPITAL: return "Ganymede"
		NpcScheduler.locations.OFFICE: return "Ganymede"
		_: return "Title"
