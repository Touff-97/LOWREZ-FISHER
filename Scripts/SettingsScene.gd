extends "res://Scripts/Scene.gd"

onready var master_increment = $Margin/VBox/Setting1/HBox/Increment
onready var music_increment = $Margin/VBox/Setting2/HBox/Increment
onready var sound_increment = $Margin/VBox/Setting3/HBox/Increment
onready var back_button = $Margin/VBox/BackButton


### HOVER ###
func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


### SELECT ###
func _on_masterMinus_pressed() -> void:
	minusButton(master_increment, "Master")


func _on_masterPlus_pressed() -> void:
	plusButton(master_increment, "Master")


func _on_musicMinus_pressed() -> void:
	minusButton(music_increment, "Music")


func _on_musicPlus_pressed() -> void:
	plusButton(music_increment, "Music")


func _on_soundMinus_pressed() -> void:
	minusButton(sound_increment, "Sounds")


func _on_soundPlus_pressed() -> void:
	plusButton(sound_increment, "Sounds")


func _process(_delta: float) -> void:
# warning-ignore:narrowing_conversion
	master_increment.rect_size.x = volumeToSize(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
# warning-ignore:narrowing_conversion
	music_increment.rect_size.x = volumeToSize(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
# warning-ignore:narrowing_conversion
	sound_increment.rect_size.x = volumeToSize(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sounds")))


func minusButton(setting: Node, bus: String) -> void:
	if setting.rect_size.x > 0:
		emit_signal("sound_effect", "Select")
		setting.rect_size.x -= 8
	else:
		emit_signal("sound_effect", "Error")
	var value = sizeToVolume(setting.rect_size.x)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)


func plusButton(setting: Node, bus: String) -> void:
	if setting.rect_size.x < 18:
		emit_signal("sound_effect", "Select")
		setting.rect_size.x += 8
	else:
		emit_signal("sound_effect", "Error")
	var value = sizeToVolume(setting.rect_size.x)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)


func sizeToVolume(size: int) -> int:
	var volume: int
	match size:
		0:
			volume = -80
		8:
			volume = -20
		16:
			volume = -10
		24:
			volume = 0
	return volume


func volumeToSize(volume: int) -> int:
	var size: int
	match volume:
		-80:
			size = 0
		-20:
			size = 8
		-10:
			size = 16
		0:
			size = 24
	return size


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()
