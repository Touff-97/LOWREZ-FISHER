extends Node

onready var music_player = $MusicPlayer
onready var sound_player = $SoundPlayer


func loadSong(song: String) -> void:
	print("Loading " + song)
	if not find_node(song).playing:
		find_node(song).play()


func loadSound(sound: String) -> void:
	print("Playing " + sound)
	find_node(sound).play()
