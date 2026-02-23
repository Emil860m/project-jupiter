extends CharacterBody3D


var target_location: Vector3
var speed: int = 1000


func _physics_process(delta: float) -> void:
	if target_location.distance_to(global_position) > 0.2:
		velocity = global_position.direction_to(target_location).normalized() * speed * delta
		move_and_slide()
