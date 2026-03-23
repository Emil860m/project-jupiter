extends Node

@export var interacted = false
@export var time_pass = 5

var interact: Callable = func ():
	pass
	
func runner():
	if !interacted:
		print("First time interaction")
		print("Do something with the time")
		Globals.increment_timestep(11)
	interacted = true
	interact.call()
	

func handle_click(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			SignalBus.object_clicked.emit(self)
			
