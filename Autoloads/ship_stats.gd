extends Node

## Ship Stuff

var has_upgraded_fuel_cap = false
@export var travel_speed: float = 20

var fuel = 10
var fuel_cap = 10

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
	ShipStatTypes.speed: 3,
	ShipStatTypes.fuel_consumption: 3,
	ShipStatTypes.durability: 3,
	ShipStatTypes.maneuverability: 3,
	ShipStatTypes.radiation_protection: 3,
}

func spend_fuel(fuel_spent: int): 
	fuel -= fuel_spent

func refuel():
	fuel = fuel_cap
	
func repair():
	damage = 0

func upgrade_fuel_cap():
	if !has_upgraded_fuel_cap:
		fuel_cap = fuel_cap * 2

## Event Stuff
var rng = RandomNumberGenerator.new()

func event_succes_roll(success_chance: int) -> bool:
	return success_chance >= rng.randi_range(1,100)
