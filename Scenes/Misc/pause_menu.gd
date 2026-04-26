extends Node2D

@onready var background: TextureRect = $CanvasLayer/Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.size = get_viewport_rect().size * 0.75
	background.modulate.a = 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_resume_button_button_up()
	pass



func _on_resume_button_button_up() -> void:
	get_tree().paused = false
	queue_free()


func _on_option_button_button_up() -> void:
	var option_scene = load("res://Scenes/Misc/options.tscn")
	var option_scene_instance = option_scene.instantiate()
	add_child(option_scene_instance)
	pass # Replace with function body.
