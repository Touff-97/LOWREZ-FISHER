extends TextureButton

export var next_scene : String = ""


func _on_BackButton_pressed() -> void:
	disabled = true
	next_scene = "MainMenuScene"
