extends "res://Scripts/Scene.gd"

onready var skybox = $SkyBox
onready var back_button = $Fishing/Margin/BackButton

signal fish_caught


func _ready() -> void:
	connect("fish_caught", get_node("/root/Main"), "_on_fishCaught")


func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_FishButton_pressed() -> void:
	emit_signal("sound_effect", "Select")


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()


func _on_Fishing_sound_effect(effect: String) -> void:
	emit_signal("sound_effect", effect)


func _on_Fishing_fish_caught() -> void:
	emit_signal("fish_caught")
