extends Node

@export var stat_needed_for_advantage: int = 12
@export var stat_needed_to_not_have_disadvantage: int = 11


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


func adjust_stats(d_physical: int, d_mental: int, d_social: int, d_education: int):
	Stats[PlayerStatTypes.physical] += d_physical
	Stats[PlayerStatTypes.mental] += d_mental
	Stats[PlayerStatTypes.social] += d_social
	Stats[PlayerStatTypes.education] += d_education


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
			luck = rng.randi_range(1,num_sides)
		RollKind.advantage:
			luck = max(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		RollKind.disadvantage:
			luck = min(rng.randi_range(1,num_sides), rng.randi_range(1,num_sides))
		_: pass
	return luck + avg >= succes


func decide_rollkind(stat_type: PlayerStatTypes) -> RollKind:
	var rollkind: RollKind = RollKind.normal
	if Stats[stat_type] >= stat_needed_for_advantage:
		rollkind = RollKind.advantage
	elif Stats[stat_type] < stat_needed_to_not_have_disadvantage:
		rollkind = RollKind.disadvantage
	
	return rollkind

func single_check(success: int, stat_type: PlayerStatTypes) -> bool:
	var rollkind: RollKind = decide_rollkind(stat_type)
	return dialog_check(success, rollkind, [stat_type])

func physical_check(success: int) -> bool:
	return single_check(success, PlayerStatTypes.physical)

func mental_check(success: int) -> bool:
	return single_check(success, PlayerStatTypes.mental)

func social_check(success: int) -> bool:
	return single_check(success, PlayerStatTypes.social)

func education_check(success: int) -> bool:
	return single_check(success, PlayerStatTypes.education)
