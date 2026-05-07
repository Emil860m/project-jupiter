extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("fade_out")	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneController.goto_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.
