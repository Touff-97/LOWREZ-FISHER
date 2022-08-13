extends "res://Scripts/Scene.gd"

onready var settings_button = $MarginContainer/VBox/HBox/Options
onready var play_button = $MarginContainer/VBox/HBox/Play
onready var quit_button = $MarginContainer/VBox/HBox/Quit


### HOVER ###
func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


### SELECT ###
func _on_Options_pressed() -> void:
	settings_button.disabled = true
	emit_signal("sound_effect", "Select")
	next_scene = "SettingsScene"
	transitionToScene()


func _on_Play_pressed() -> void:
	play_button.disabled = true
	emit_signal("sound_effect", "Select")
	next_scene = "MapScene"
	transitionToScene()


func _on_Quit_pressed() -> void:
	quit_button.disabled = true
	emit_signal("sound_effect", "Select")
	yield(get_tree().create_timer(0.2), "timeout") # Time for select sound to finish
	get_tree().quit()


func _on_Itch_pressed() -> void:
	emit_signal("sound_effect", "Select")
# warning-ignore:return_value_discarded
	OS.shell_open("https://touff97.itch.io/lowrez-fisher")


func _on_Youtube_pressed() -> void:
	emit_signal("sound_effect", "Select")
# warning-ignore:return_value_discarded
	OS.shell_open("https://www.youtube.com/channel/UCWPOkDtRTf_BDrCNvQ3CMhw")
