extends Node2D

#Canvas
@onready var starters: CanvasLayer = $Starters
@onready var main_course: CanvasLayer = $MainCourse
@onready var dessert: CanvasLayer = $Dessert
@onready var main_view: CanvasLayer = $MainView
@onready var leave_scene: CanvasLayer = $LeaveScene
#Starters
@onready var starter_1: Buff = $Starters/VBoxContainer/Starter1
@onready var starter_2: Buff = $Starters/VBoxContainer/Starter2
@onready var starter_3: Buff = $Starters/VBoxContainer/Starter3
#Mains
@onready var main_1: Buff = $MainCourse/VBoxContainer/Main1
@onready var main_2: Buff = $MainCourse/VBoxContainer/Main2
@onready var main_3: Buff = $MainCourse/VBoxContainer/Main3
#Desserts
@onready var dessert_1: Buff = $Dessert/VBoxContainer/Dessert1
@onready var dessert_2: Buff = $Dessert/VBoxContainer/Dessert2
@onready var dessert_3: Buff = $Dessert/VBoxContainer/Dessert3

@export var scene_to_load: String

var courses
var buffs: Array[Buff]

func _ready() -> void:
	starter_1.connect("pressed", _dish_chosen.bind(starter_1,1))
	starter_2.connect("pressed", _dish_chosen.bind(starter_2,1))
	starter_3.connect("pressed", _dish_chosen.bind(starter_3,1))
	main_1.connect("pressed", _dish_chosen.bind(main_1,2))
	main_2.connect("pressed", _dish_chosen.bind(main_2,2))
	main_3.connect("pressed", _dish_chosen.bind(main_3,2))
	dessert_1.connect("pressed", _dish_chosen.bind(dessert_1,3))
	dessert_2.connect("pressed", _dish_chosen.bind(dessert_2,3))
	dessert_3.connect("pressed", _dish_chosen.bind(dessert_3,3))

func _on_course_button_up(num_courses: int) -> void:
	courses = num_courses
	if num_courses == 1:
		main_course.visible = true
	else:
		starters.visible = true
	main_view.visible = false
	
func _dish_chosen(buff: Buff, dish_num: int):
	buffs.append(buff)
	print("this is num dishes: %d" %dish_num)
	print("this is num courses: %d" %courses)
	if dish_num == courses or courses == 1:
		print("hvad fanden")
		main_course.visible = false
		dessert.visible = false
		leave_scene.visible = true
		for b in buffs:
			b.apply_buff()
	if dish_num == 1:
		starters.visible = false
		main_course.visible = true
	if dish_num == 2:
		main_course.visible = false
		dessert.visible = true
	pass


func _on_leave_button_pressed() -> void:
	SceneController.goto_scene(scene_to_load)
