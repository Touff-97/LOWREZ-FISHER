extends Control

export(String) var next_scene = ""
export(String) var next_music = ""

signal scene_transition(scene)
signal song_transition(song)
signal sound_effect(effect)


func _ready() -> void:
	if next_music:
		transitionToSong()


### SCENE LOGIC ###
func transitionToScene() -> void:
	emit_signal("scene_transition", next_scene)


func deleteCurrentScene() -> void:
	queue_free()


### AUDIO LOGIC ###
func transitionToSong() -> void:
	emit_signal("song_transition", next_music)
