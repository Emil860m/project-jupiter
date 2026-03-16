extends Node



func set_movement_velocity(nav_point: Vector3, pos: Vector3, SPEED = 5.0) -> Vector3:
	return (nav_point - pos).normalized() * SPEED
