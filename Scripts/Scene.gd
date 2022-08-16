extends Control

export(String) var next_scene = ""
export(String) var next_music = ""
export(bool) var hud_on = false
export(bool) var out_of_fish = false

export(Dictionary) var inventory = {}
export(Dictionary) var scene_data = {}

signal scene_transition(scene)
signal song_transition(song)
signal sound_effect(effect)

signal fetch_inventory(origin)

signal toggle_hud(is_hud)


func _ready() -> void:
	if next_music:
		transitionToSong()
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("toggle_hud", hud_on)


### SCENE LOGIC ###
func transitionToScene() -> void:
	emit_signal("scene_transition", next_scene)


func deleteCurrentScene() -> void:
	queue_free()


### AUDIO LOGIC ###
func transitionToSong() -> void:
	emit_signal("song_transition", next_music)


### SAVE AND LOAD LOGIC ###
func save_node() -> Dictionary:
	var temp_dict := {}
	temp_dict[get_name()] = scene_data
	return temp_dict


func load_node(data: Dictionary) -> void:
	scene_data = data
