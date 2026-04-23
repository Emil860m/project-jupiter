extends Node

@onready var bgm_emitter = $BgmEmitter

func _ready():
	bgm_emitter.play()

func set_bgm(location):
	bgm_emitter.set_parameter("Location", get_location_parameter(location))
	print(bgm_emitter.get_parameter("Location"))

func get_location_parameter(loc: NpcScheduler.locations) -> String:
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
