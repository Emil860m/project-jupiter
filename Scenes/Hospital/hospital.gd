extends Node3D


@onready var daddy_door: StaticBody3D = $DaddyDoor
@onready var worker_door: StaticBody3D = $WorkerDoor

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		daddy_door.setOpen()
		worker_door.setOpen()
		
