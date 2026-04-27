extends Node

#@export var interacted = false
@export var time_pass = 5
@export var object_id: String
@export var meshs: Array[MeshInstance3D]
@export var outline_shader: ShaderMaterial

func show_shader():
	for mesh in meshs:
		mesh.material_overlay = outline_shader

func hide_shader():
	for mesh in meshs:
		mesh.material_overlay = null

var interact: Callable = func ():
	pass
	
func runner():
	if !Globals.has_interacted(object_id):
		print("First time interaction")
		print("Do something with the time")
		Globals.increment_timestep(time_pass)
	Globals.add_to_interact_set(object_id)
	interact.call()
	

func handle_click(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			SignalBus.object_clicked.emit(self)
			
