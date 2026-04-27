extends Node

## Ship Stuff

var has_upgraded_fuel_cap = false
@export var travel_speed: float = 20
@export var stat_min_allowed_value = 8
@export var max_allowed_stat = 20

var fuel = 50
var fuel_cap = 50

var damage = 0
const severity_const = 3

enum ShipStatTypes {
	speed,
	fuel_consumption,
	durability,
	maneuverability,
	radiation_protection,
}

var Stats = {
	ShipStatTypes.speed: 10,
	ShipStatTypes.fuel_consumption: 10, # High stat means low consumption
	ShipStatTypes.durability: 10,
	ShipStatTypes.maneuverability: 10,
	ShipStatTypes.radiation_protection: 10,
}

var _unused_stat_allocation_points: int = 2

func get_unused_stat_allocation_points() -> int:
	return _unused_stat_allocation_points

func allocate_stat(stat_type: ShipStatTypes, amount = 1):
	if _unused_stat_allocation_points >= 0 + amount and Stats[stat_type] + amount <= max_allowed_stat:
		_unused_stat_allocation_points -= amount
		Stats[stat_type] += amount
	else:
		assert(false, "Tried to allocate stats without any available stat points or beyond max value")
		pass

func de_allocate_stat(stat_type: ShipStatTypes, amount = 1):
	if Stats[stat_type] >= stat_min_allowed_value + amount:
		_unused_stat_allocation_points += amount
		Stats[stat_type] -= amount
	else:
		assert(false, "Tried to de-allocate stats beyond the minimum")
		pass


func damage_ship(damage_number: int):
	damage += damage_number
	if damage > 10:
		SceneController.should_tow_truck = true

func spend_fuel(fuel_spent: int):  # Note: also used by events to reduce fuel
	var total_fuel_spent = fuel_spent / (0.1 * Stats[ShipStatTypes.fuel_consumption])
	if total_fuel_spent > fuel:
		SceneController.should_tow_truck = true
		return
	fuel -= fuel_spent / (0.1 * Stats[ShipStatTypes.fuel_consumption])

func refuel():
	fuel = fuel_cap
	
func repair():
	damage = 0

func upgrade_fuel_cap(added_fuel: int):
	fuel_cap += added_fuel
	refuel()

func upgrade_poj(added_poj: int):
	_unused_stat_allocation_points += added_poj

## Event Stuff
var rng = RandomNumberGenerator.new()

func event_succes_roll(success_chance: int) -> bool:
	return success_chance >= rng.randi_range(1,100)



# misc
func stat_type_to_string(type: ShipStatTypes) -> String:
	match type:
		ShipStatTypes.radiation_protection: return "Radiation Protection"
		ShipStatTypes.durability: return "Durability"
		ShipStatTypes.maneuverability: return "Maneuverability"
		ShipStatTypes.speed: return "Speed"
		ShipStatTypes.fuel_consumption: return "Fuel Efficiency"
		_:
			assert(false, "invalid stat type")
			return ""
