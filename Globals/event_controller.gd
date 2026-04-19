extends Node

func fetch_event() -> String:
	return "event_oldProbe"


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
