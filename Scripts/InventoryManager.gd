extends Node

export(Dictionary) var game_data = {
									"PlayerInventory": {
										"fishes": 0,
										"coins": 0
									}
								}

var path : String = "user://savedata.save"

signal data_loaded(data)


func load_game() -> void:
	var save_game = File.new()
	if not save_game.file_exists(path):
		return
#
	save_game.open(path, File.READ)
	
	var save_game_data = JSON.parse(save_game.get_as_text())
	if typeof(save_game_data.result) == TYPE_DICTIONARY:
		game_data = save_game_data.result
		emit_signal("data_loaded", game_data)
	else:
		 push_error("Unexpected results.")
	
	save_game.close()


func save_game() -> void:
	var save_game = File.new()
	save_game.open(path, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save_node")
		save_game.store_line(to_json(node_data))
	save_game.close()
