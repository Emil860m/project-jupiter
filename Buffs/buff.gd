extends Node
class_name Buff

var _duration: int
var _stat: PlayerStats.PlayerStatTypes
var _amount: int
var _applied: bool = false
var _time_step_at_buff: int


func setup(duration: int, stat: PlayerStats.PlayerStatTypes, amount: int):
	SignalBus.time_step_changed.connect(_on_time_changed)
	self._duration = duration
	self._stat = stat
	self._amount = amount
	self._time_step_at_buff = Globals.current_timestep
	apply_buff()
	
func apply_buff():
	_applied = true
	PlayerStats.Stats[_stat] += _amount

func _remove_buff():
	PlayerStats.Stats[_stat] -= _amount
	self.queue_free()
	pass

func _on_time_changed():
	if _applied:
		if Globals.current_timestep - _time_step_at_buff >= _duration:
			_remove_buff()
