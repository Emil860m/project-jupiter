extends Control

@export var label_text: String
@onready var dialog_text: Label = $VSplitContainer/DialogText

func _ready() -> void:
	dialog_text.text = label_text
	



func _on_button_pressed() -> void:
	self.visible = false
	pass # Replace with function body.
