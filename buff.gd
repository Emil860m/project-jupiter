extends Node
class_name Buff


@export var duration: int
@export var time_step_at_buff: int
@export var stat: PlayerStats.PlayerStatTypes
@export var amount: int


func setup(duration: int, stat: PlayerStats.PlayerStatTypes, amount: int):
	SignalBus.time_step_changed.connect(_on_time_changed)
	self.duration = duration
	self.stat = stat
	self.amount = amount
	self.time_step_at_buff = Globals.current_timestep
	apply_buff()

func apply_buff():
	PlayerStats.Stats[stat] += amount

func _remove_buff():
	PlayerStats.Stats[stat] -= amount
	self.queue_free()
	pass

func _on_time_changed():
	print("noget sker")
	if Globals.current_timestep - time_step_at_buff >= duration:
		_remove_buff()
