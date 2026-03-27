extends Node

## Player stuff

enum PlayerStatTypes {
	physical,
	mental,
	social,
	education,
}

var PlayerStats = {
		PlayerStatTypes.physical: 3,
		PlayerStatTypes.mental: 3,
		PlayerStatTypes.social: 3,
		PlayerStatTypes.education: 3,
	}

## RPG Stuff

var rng = RandomNumberGenerator.new()

enum RollKind {
	normal,
	advantage,
	disadvantage,
}

func roll_die(num_sides: int, succes: int, roll_kind: RollKind) -> bool:
	match roll_kind:
		RollKind.normal:
			return rng.randi_range(1,num_sides) >= succes
		RollKind.advantage:
			var max = max(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
			return max >= succes
		RollKind.disadvantage:
			var min = min(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
			return min >= succes
		_: return false
