extends StaticBody3D

@onready var fadeout_comp: FadeoutComponent = $FadeoutComponent
@onready var ganymede_wall: MeshInstance3D = $GanymedeWall
@onready var ganymede_pillar_2: MeshInstance3D = $GanymedePillar2
@onready var ganymede_pillar: MeshInstance3D = $GanymedePillar
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func _ready() -> void:
	fadeout_comp.mats = [ganymede_pillar, ganymede_pillar_2, ganymede_wall]
	fadeout_comp.collision = collision_shape_3d

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group('Player'):
		if body.velocity.z > 0:
			fadeout_comp.fade_out = true
		else:
			fadeout_comp.fade_out = false
		fadeout_comp.set_physics_process(true)
		
