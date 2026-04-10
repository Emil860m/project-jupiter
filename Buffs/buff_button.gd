extends Node
class_name Buff_Button

@export var duration: int
@export var stat: PlayerStats.PlayerStatTypes
@export var amount: int

func apply_buff():
	var buff = Buff.new()
	buff.setup(duration,stat,amount)
