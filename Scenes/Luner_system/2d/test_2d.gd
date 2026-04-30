extends Node2D

@onready var _animated_sprite_1 = $AnimatedSprite2D

var location_id = NpcScheduler.locations.PLANET_VIEW

func _ready() -> void:
	_animated_sprite_1.play("default")
	
