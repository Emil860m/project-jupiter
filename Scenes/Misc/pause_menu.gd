extends Node2D

@onready var background: TextureRect = $CanvasLayer/Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.size = get_viewport_rect().size * 0.75
	background.modulate.a = 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
