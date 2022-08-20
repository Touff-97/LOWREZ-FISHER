extends TextureRect

export(NodePath) onready var background = get_node(background)
export(NodePath) onready var rod = get_node(rod)

var starting_position := Vector2(0, -472)
var ending_position := Vector2(0, 0)

var starting_light := Color(1.0, 1.0, 1.0, 1.0)
var ending_light := Color(0.3, 0.3, 0.3, 1.0)

var total_minutes := 59.0

signal day_finished


func _ready() -> void:
# warning-ignore:return_value_discarded
	connect("day_finished", get_node("/root/Main"), "_on_dayFinished")
	
	background.modulate = starting_light
	if rod:
		rod.modulate = starting_light


func _process(_delta: float) -> void:
	var time = loadTimeFromOS()
	rect_position = starting_position.linear_interpolate(ending_position, time["minute"] / total_minutes)
	background.modulate = starting_light.linear_interpolate(ending_light, time["minute"] / total_minutes)
	if rod:
		rod.modulate = starting_light.linear_interpolate(ending_light, time["minute"] / total_minutes)
	
	if time["minute"] == 59 and time["second"] >= 58:
		emit_signal("day_finished")
		set_process(false)


func loadTimeFromOS() -> Dictionary:
	return OS.get_time()
