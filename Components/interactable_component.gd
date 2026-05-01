extends Node

#@export var interacted = false
@export var time_pass = 5
@export var meshs: Array[MeshInstance3D]
@export var outline_shader: ShaderMaterial

var object_id = ""

func show_shader():
	for mesh in meshs:
		mesh.material_overlay = outline_shader

func hide_shader():
	for mesh in meshs:
		mesh.material_overlay = null

var interact: Callable = func ():
	pass
	
func runner():
	interact.call()
	if !Globals.has_interacted(object_id):
		Globals.increment_timestep(time_pass)
	Globals.add_to_interact_set(object_id)
	

func handle_click(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			SignalBus.object_clicked.emit(self, get_parent().get_node("CollisionShape3D"))
			
