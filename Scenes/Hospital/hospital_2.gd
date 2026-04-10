extends Node3D

@onready var worker_room: CSGBox3D = $NavigationRegion3D/CSGCombiner3D/WorkerRoom
@onready var worker_room_door: CSGBox3D = $NavigationRegion3D/CSGCombiner3D/WorkerRoomDoor


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.time_step_changed.connect(_on_updated_timestep)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		print(PlayerStats.Stats[PlayerStats.PlayerStatTypes.mental])
		print(PlayerStats.dialog_check(6, PlayerStats.RollKind.disadvantage, [PlayerStats.PlayerStatTypes.physical, PlayerStats.PlayerStatTypes.mental]))


func _on_updated_timestep():
	if ((Globals.current_timestep % 10) % 2 == 0):
		worker_room.visible = false
		worker_room_door.visible = false
	else:
		worker_room.visible = true
		worker_room_door.visible = true
