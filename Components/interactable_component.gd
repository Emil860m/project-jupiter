extends Node

#@export var interacted = false
@export var time_pass = 5

var interact: Callable = func ():
	pass
	
func runner():
	if !Globals.has_interacted(self):
		print("First time interaction")
		print("Do something with the time")
		Globals.increment_timestep(time_pass)
	Globals.add_to_interact_set(self)
	interact.call()
	

func handle_click(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("move_click"):
			SignalBus.object_clicked.emit(self)
			
