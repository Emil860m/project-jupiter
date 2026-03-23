extends Area3D

var fade_out = false
var mat = null

func _physics_process(delta: float) -> void:
	var t = delta * 0.8
	if (fade_out && mat.albedo_color.a >= 0.2 || !fade_out && mat.albedo_color.a <= 1):
		if (fade_out):
			mat.albedo_color.a = mat.albedo_color.a - (mat.albedo_color.a -0.1 ) * t
		if (!fade_out):
			mat.albedo_color.a = mat.albedo_color.a + (1.5 - mat.albedo_color.a) * t
