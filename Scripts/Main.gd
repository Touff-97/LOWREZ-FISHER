extends Node2D

onready var scene_manager = $SceneManager
onready var audio_manager = $AudioManager


func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), -10)


func _on_sceneTransition(scene: String) -> void:
	print("Sending scene to load")
	scene_manager.loadScene(scene)


func _on_songTransition(song: String) -> void:
	print("Sending song to load")
	audio_manager.loadSong(song)


func _on_soundEffect(sound: String) -> void:
	print("Sending sound to load")
	audio_manager.loadSound(sound)
