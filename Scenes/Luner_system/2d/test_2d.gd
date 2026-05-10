extends Node2D

@onready var _animated_sprite_1 = $AnimatedSprite2D
@onready var _animated_sprite_2 = $bootUP

var location_id = NpcScheduler.locations.PLANET_VIEW

#TODO temporary
@onready var dialog_comp = $DialogComponent


func _ready() -> void:
	_animated_sprite_1.play("default")
	_animated_sprite_2.play("default")
	
	if not Flags.get_flag("ContextHasBeenRead"):
		Flags.set_flag("ContextHasBeenRead")
		dialog_comp.start_dialog()


func _on_boot_up_animation_finished() -> void:
	_animated_sprite_2.stop()
	_animated_sprite_2.visible = false
