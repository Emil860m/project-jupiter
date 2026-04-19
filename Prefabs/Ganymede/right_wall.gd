extends StaticBody3D

@onready var fadeout_comp: FadeoutComponent = $FadeoutComponent
@onready var ganymede_wall: MeshInstance3D = $GanymedeWall
@onready var ganymede_pillar_2: MeshInstance3D = $GanymedePillar2
@onready var ganymede_pillar: MeshInstance3D = $GanymedePillar


func _ready() -> void:
	fadeout_comp.mats = [ganymede_pillar, ganymede_pillar_2, ganymede_wall]

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	print(body)
	if body.is_in_group('Player'):
		print('kommer ned')
		var direction = body.global_position - global_position	
		if direction.x > 0:
			fadeout_comp.fade_out = true
		else:
			fadeout_comp.fade_out = false
		fadeout_comp.set_physics_process(true)
		
