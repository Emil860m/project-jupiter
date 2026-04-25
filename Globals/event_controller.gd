extends Node

@export var long_journey_cutoff: int = 250
@export var short_journey_cutoff: int = 100

var events: Array[Event] = []

func _ready() -> void:
	_load_events()


func fetch_event(start_time, end_time, start_pos, end_pos) -> String:
	# return "event_longExposure"
	
	if not Flags.get_flag("TutorialEventDone"):
		Flags.set_flag("TutorialEventDone")
		return "event_tutorial"
	
	for e in events:
		if e.is_applicable_to_journey(start_time, end_time, start_pos, end_pos):
			return e.eventID
	
	refresh_events()
	
	for e in events:
		if e.is_applicable_to_journey(start_time, end_time, start_pos, end_pos):
			return e.eventID
	
	assert(false)
	return "event_spaceDebris"

func refresh_events():
	for e in events:
		e.refresh()
	
	events.shuffle()


func resolve_outcome(passed_time: int, spent_fuel: int, damage_taken: int):
	Globals.increment_timestep(passed_time)
	ShipStats.spend_fuel(spent_fuel)
	ShipStats.damage_ship(damage_taken)

# auxiliaries
func _load_events():
	# Callables
	var default_callable = func(_start_time, _end_time, _start_pos, _end_pos):
		return true
	
	var long_route_callable = func(_start_time, _end_time, start_pos, end_pos):
		return (end_pos - start_pos).length() >= long_journey_cutoff
	
	var short_route_callable = func(_start_time, _end_time, start_pos, end_pos):
		return (end_pos - start_pos).length() <= short_journey_cutoff
	
	# event_spaceDebris
	var event_to_add = Event.new("event_spaceDebris", default_callable)
	events.append(event_to_add)
	
	# event_oldProbe
	event_to_add = Event.new("event_oldProbe", long_route_callable)
	events.append(event_to_add)
	
	# event_carelessness
	event_to_add = Event.new("event_carelessness", short_route_callable)
	events.append(event_to_add)
	
	# event_marvelAtJupiter
	event_to_add = Event.new("event_marvelAtJupiter", default_callable)
	events.append(event_to_add)
	
	# event_longExposure
	event_to_add = Event.new("event_longExposure", long_route_callable)
	events.append(event_to_add)
	
	events.shuffle()


### EVENT CHECKS ###

# auxiliary NOT TO BE USED BY DIALOG DIRECTLY
func _simple_check(stat: int, base_value: int) -> bool:
	if base_value + stat >= randi_range(1, 100):
		return true
	else:
		return false

func _stakes_check(stat: int, base_value=50, stat_impact=10, stat_expectation=10):
	if base_value + stat_impact * (stat - stat_expectation) >= randi_range(1,100):
		return true
	else:
		return false

func _detriment_check(stat: int, base_value=50, stat_impact=10, stat_expectation=10):
	if base_value - stat_impact * (stat - stat_expectation) >= randi_range(1,100):
		return true
	else:
		return false

# used functions
func simple_durability_check(base_value: int) -> bool:
	return _simple_check(ShipStats.Stats[ShipStats.ShipStatTypes.durability], base_value)

func simple_maneuverability_check(base_value: int) -> bool:
	return _simple_check(ShipStats.Stats[ShipStats.ShipStatTypes.durability], base_value)

func simple_radiation_check(base_value: int) -> bool:
	return _simple_check(ShipStats.Stats[ShipStats.ShipStatTypes.durability], base_value)


func stakes_durability_check():
	return _stakes_check(ShipStats.Stats[ShipStats.ShipStatTypes.durability])

func stakes_maneuverability_check():
	return _stakes_check(ShipStats.Stats[ShipStats.ShipStatTypes.maneuverability])

func stakes_radiation_check():
	return _stakes_check(ShipStats.Stats[ShipStats.ShipStatTypes.radiation_protection])

func detriment_speed_check():
	return _detriment_check(ShipStats.Stats[ShipStats.ShipStatTypes.speed])
