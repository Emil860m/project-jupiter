extends Area3D
class_name FadeoutComponent

var fade_out = false
var mats: Array[Node]
var collision: CollisionShape3D

func _ready() -> void:
	self.set_physics_process(false)

func _physics_process(delta: float) -> void:
	var t = delta * 0.8
	for mat in mats:
		if (!fade_out && mat.transparency > 0 || fade_out && mat.transparency <= 0.7):
			if (fade_out):
				mat.transparency = mat.transparency +  0.25 * t
				collision.disabled = true
			if (!fade_out):
				collision.disabled = false
				mat.transparency = mat.transparency - 0.25 * t
		else:
			self.set_physics_process(false)
