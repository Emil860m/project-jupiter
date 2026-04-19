extends Area3D
class_name FadeoutComponent

var fade_out = false
var mats: Array[Node]

func _ready() -> void:
	self.set_physics_process(false)

func _physics_process(delta: float) -> void:
	var t = delta * 0.8
	for mat in mats:
		if (!fade_out && mat.transparency <= 0.8 || fade_out && mat.transparency >= 0):
			if (fade_out):
				mat.transparency = mat.transparency + (mat.transparency + 0.1 ) * t
			if (!fade_out):
				mat.transparency = mat.transparency - (mat.transparency) * t
			print(mat.transparency)
		else:
			self.set_physics_process(false)
