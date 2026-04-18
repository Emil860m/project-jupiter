extends Node

# When creating a new flag, add a flag like this example:
var testflag: bool = false
# And also add a function. This is the callable that should be in the NpcScheduler
func get_testflag():
	return testflag
# if a flag should be false for the event, add this function
func get_reverse_testflag():
	return not testflag
