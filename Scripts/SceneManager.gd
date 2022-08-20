extends Node

export(NodePath) onready var main_node = get_node(main_node)


func _ready() -> void:
	loadScene("SplashScene")


func loadScene(scene: String) -> void:
	print(scene)
	var file = File.new()
	var path = "res://Scenes/" + scene + ".tscn"
	if file.file_exists(path):
		print(path)
		var new_scene = load(path).instance()
		new_scene.connect("scene_transition", main_node, "_on_sceneTransition")
		new_scene.connect("song_transition", main_node, "_on_songTransition")
		new_scene.connect("sound_effect", main_node, "_on_soundEffect")
		new_scene.connect("toggle_hud", main_node, "_on_toggleHud")
		new_scene.connect("update_hud", main_node, "_on_updateHud")
		add_child(new_scene)
		move_child(new_scene, 0)
		yield(get_tree().create_timer(1.0), "timeout")
		if get_child_count() > 1:
			get_child(1).queue_free()
			print("Scene loaded")
