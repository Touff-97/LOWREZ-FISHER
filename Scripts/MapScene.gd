extends "res://Scripts/Scene.gd"

onready var back_button = $Margin/BackButton


func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_Town_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_Town_pressed(town: String) -> void:
	find_node(town).disabled = true
	emit_signal("sound_effect", "Select")
	next_scene = town + "Scene"
	transitionToScene()


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()
