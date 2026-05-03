extends Node

@onready var bgm_emitter = $BgmEmitter
@onready var amb_emitter = $AmbianceEmitter

@onready var ui_emitters = $UIEmitters
@onready var sfx_emitters = $SFXEmitters

var master_vol: float = 0.5:
	set(new_val):
		assert(new_val <= 1.0)
		master_vol = new_val
		set_volumes()
var music_vol: float = 0.5:
	set(new_val):
		assert(new_val <= 1.0)
		music_vol = new_val
		set_volumes()
var sound_vol: float = 0.5:
	set(new_val):
		assert(new_val <= 1.0)
		sound_vol = new_val
		set_volumes()


func _ready():
	bgm_emitter.play()
	
	set_volumes()

func set_volumes():
	var actual_music = master_vol * music_vol
	var actual_sound = master_vol * sound_vol
	
	bgm_emitter.volume = actual_music
	for emitter in ui_emitters.get_children():
		emitter.volume = actual_sound
	
	for emitter in sfx_emitters.get_children():
		emitter.volume = actual_sound
	
	set_ambient_volume()

func set_ambient_volume():
	amb_emitter.volume = master_vol * music_vol * 0.5 # ambience is half as loud as music

func set_bgm(location, loading=false):
	if location != NpcScheduler.locations.PONS and location != NpcScheduler.locations.RATIONALE:
		set_in_flight(false)
	
	if loading:
		amb_emitter.volume = 0.0
	else:
		set_ambient_volume()
	
	bgm_emitter.set_parameter("Location", get_location_parameter(location))
	amb_emitter.set_parameter("Location", get_location_parameter(location))
	
	set_ambient_volume()

func set_in_flight(is_in_flight: bool):
	bgm_emitter.set_parameter("inFlight", is_in_flight)

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


# Boops

@onready var low_boop = $UIEmitters/LowBoop
@onready var mid_boop = $UIEmitters/MidBoop
@onready var high_boop = $UIEmitters/HighBoop

func play_low_boop():
	low_boop.play()

func play_mid_boop():
	mid_boop.play()

func play_high_boop():
	high_boop.play()


# SFX

@onready var dmg = $SFXEmitters/DmgEmitter
@onready var elevator = $SFXEmitters/ElevatorEmitter

func play_take_damage(amount = 1):
	dmg.set_parameter("DMGSeverity", amount)
	dmg.play()

func play_elevator():
	elevator.play()
