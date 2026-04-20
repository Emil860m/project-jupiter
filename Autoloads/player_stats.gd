extends Node

## Player stuff


enum PlayerStatTypes {
	physical,
	mental,
	social,
	education,
}

var Stats = {
		PlayerStatTypes.physical: 10,
		PlayerStatTypes.mental: 10,
		PlayerStatTypes.social: 10,
		PlayerStatTypes.education: 10,
	}

## RPG Stuff

var rng = RandomNumberGenerator.new()

enum RollKind {
	normal,
	advantage,
	disadvantage,
}


func dialog_check(succes: int, roll_kind: RollKind, stats: Array[PlayerStatTypes], num_sides = 6) -> bool:
	var sum = stats.reduce(func(accum,elem): return Stats[elem] + accum, 0)
	var avg = sum / stats.size()
	var luck = 0
	match roll_kind:
		RollKind.normal:
			luck = rng.randi_range(1,num_sides) >= succes
		RollKind.advantage:
			luck = max(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		RollKind.disadvantage:
			luck = min(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		_: pass
	return luck + avg >= succes
