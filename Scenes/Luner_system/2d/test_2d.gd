extends Node2D

@onready var _animated_sprite_1 = $AnimatedSprite2D

var location_id = NpcScheduler.locations.PLANET_VIEW

#TODO temporary
@onready var dialog_comp = $DialogComponent


func _ready() -> void:
	_animated_sprite_1.play("default")
	
	if not Flags.get_flag("ContextHasBeenRead"):
		Flags.set_flag("ContextHasBeenRead")
		dialog_comp.start_dialog()
