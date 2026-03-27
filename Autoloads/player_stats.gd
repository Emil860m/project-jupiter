extends Node

## Player stuff

enum PlayerStatTypes {
	physical,
	mental,
	social,
	education,
}

var Stats = {
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


func dialog_check(succes: int, roll_kind: RollKind, stats: Array[PlayerStatTypes], num_sides = 6) -> bool:
	var sum = 0 
	for stat in stats:
		sum += Stats[stat]
	var avg = (sum / stats.size())
	var result = 0
	match roll_kind:
		RollKind.normal:
			result = rng.randi_range(1,num_sides) >= succes
		RollKind.advantage:
			result = max(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		RollKind.disadvantage:
			result = min(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		_: pass
	return result + avg >= succes
