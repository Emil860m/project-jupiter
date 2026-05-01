extends Node2D


var next_scene: String
var poster: String
var other_posters: Array[String]
var location_id := NpcScheduler.locations.LOADING
@onready var canvasLayer := $CanvasLayer
@onready var timeLabel := $CanvasLayer/TextureRect2/Label
@onready var transition_timer := $transition_timer
@onready var blink_timer := $blink_timer
@export var poster_amount_x := 5
@export var poster_amount_y := 2
@export var poster_size_scale := 0.5
@export var offset_x := -100
@export var offset_y := -50
@export var change_for_other_poster: int = 20
var timeArr: Array
var time_changed: bool = false

func _ready() -> void:
	for i in range(poster_amount_y):
		load_posters(offset_x, (i * 882 * poster_size_scale) + offset_y, load(poster))
		
	timeArr = Globals.convert_timesteps_to_time(Globals.current_timestep)
	timeLabel.text = str(timeArr[0]) + ":" + ("" if timeArr[1] >= 11  else "0") + str(timeArr[1]-1)

func load_posters(start_x, start_y, poster):
	for i in range(poster_amount_x):
		var tex = TextureRect.new()
		if randi_range(1, 100) <= change_for_other_poster:
			tex.texture = load(other_posters[randi_range(0, len(other_posters) - 1)])
		else:
			tex.texture = poster
		tex.scale *= poster_size_scale
		tex.position.x = start_x
		tex.position.y = start_y
		canvasLayer.add_child(tex)
		start_x += tex.size.x * poster_size_scale


func _on_timer_timeout() -> void:
	if not time_changed:
		timeLabel.visible = true
		time_changed = true
		timeLabel.text = str(timeArr[0]) + ":" + ("" if timeArr[1] >= 10  else "0") + str(timeArr[1])
		transition_timer.start(transition_timer.wait_time)
	else:
		SceneController.goto_scene(next_scene)

func _on_timer_2_timeout() -> void:
	timeLabel.visible = !timeLabel.visible
	if not time_changed:
		blink_timer.start(blink_timer.wait_time)
	else:
		timeLabel.visible = true
