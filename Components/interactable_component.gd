extends Node

@export var interacted_shader_overlay: Material

@export var interacted = false
@export var time_pass = 5

var interact: Callable = func ():
	pass

func handle_click(event: InputEvent, mesh: MeshInstance3D = null) -> void:
	if mesh == null:
		return
	if interacted:
				print("already interacted")
				return
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			interacted = true
			mesh.material_overlay = interacted_shader_overlay
			interact.call()
