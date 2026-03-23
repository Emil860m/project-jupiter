extends CSGBox3D

@onready var fadeout_comp: Area3D = $Area3D

func _ready() -> void:
	fadeout_comp.mat = self.material

func _on_area_3d_body_entered(body: Node3D) -> void:
	var direction = body.global_position - global_position	
	if direction.x > 0:
		fadeout_comp.fade_out = true
	else:
		fadeout_comp.fade_out = false
