extends Node
class_name Event

var fresh := true
var eventID: String = "event_test":
	get():
		fresh = false
		return eventID
var relevancy_checker: Callable = func(_start_time, _end_time, _start_pos, _end_pos):
	return true

func _init(ID: String, applicability_callable: Callable) -> void:
	eventID = ID
	relevancy_checker = applicability_callable
	fresh = true

func refresh():
	fresh = true

func is_applicable_to_journey(start_time, end_time, start_pos, end_pos) -> bool:
	if fresh and relevancy_checker.call(start_time, end_time, start_pos, end_pos):
		return true
	else:
		return false
