extends CSGBox3D


var color;
var fade_out = false

func _ready() -> void:
	color = material.albedo_color


func _physics_process(delta: float) -> void:
	var t = delta * 0.8
	print(material.albedo_color.a)
	if (fade_out && material.albedo_color.a >= 0.2 || !fade_out && material.albedo_color.a <= 1):
		if (fade_out):
			material.albedo_color.a = material.albedo_color.a - (material.albedo_color.a -0.1 ) * t
		if (!fade_out):
			material.albedo_color.a = material.albedo_color.a + (1.5- material.albedo_color.a) * t
	
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	var direction = body.global_position - global_position
	
	# Check direction, e.g., using Vector3 axes (x, y, z)	
	if direction.x > 0:
		print("Entering")
		fade_out = true
	else:
		fade_out = false
		print("Leaving")
