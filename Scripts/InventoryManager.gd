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
	
	while not save_game.eof_reached():
		var save_game_data = parse_json(save_game.get_line())
		game_data = save_game_data
		emit_signal("data_loaded", game_data)
	
	save_game.close()


func save_game() -> void:
	var save_game = File.new()
	save_game.open(path, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save_node")
		save_game.store_line(to_json(node_data))
	save_game.close()
