extends Node3D

@onready var worker_room: CSGBox3D = $NavigationRegion3D/CSGCombiner3D/WorkerRoom
@onready var worker_room_door: CSGBox3D = $NavigationRegion3D/CSGCombiner3D/WorkerRoomDoor


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		print(PlayerStats.education)
		worker_room.visible = !worker_room.visible
		worker_room_door.visible = !worker_room_door.visible
