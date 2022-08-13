extends TextureRect

export(NodePath) onready var background = get_node(background)

var starting_position := Vector2(0, -472)
var ending_position := Vector2(0, 0)

var starting_light
var ending_light := Color(0, 0, 0)

var total_minutes := 59.0

signal day_finished


func _ready() -> void:
	starting_light = background.modulate


func _process(delta: float) -> void:
	var time = loadTimeFromOS()
	rect_position = starting_position.linear_interpolate(ending_position, time["minute"] / total_minutes)
	background.modulate = starting_light.linear_interpolate(ending_light, time["minute"] / total_minutes)
	
	if time["minute"] == 9 and time["second"] >= 58:
		print("Night time!")
		emit_signal("day_finished")
		set_process(false)


func loadTimeFromOS() -> Dictionary:
	return OS.get_time()
