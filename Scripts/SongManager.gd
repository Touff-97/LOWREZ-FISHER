extends Node

onready var music_player = $MusicPlayer
onready var sound_player = $SoundPlayer

var prev_song : String


func loadSong(song: String) -> void:
	if not music_player.find_node(song).playing:
		if prev_song != "": # If there's a previous song, stop it
			yield(get_tree().create_timer(1.0), "timeout")
			music_player.find_node(prev_song).stop()
		print("Playing " + song)
		music_player.find_node(song).play() # Play new song
		prev_song = song # Overwrite the previous song to stop the new one later


func loadSound(sound: String) -> void:
	print("Playing " + sound)
	sound_player.find_node(sound).play()
