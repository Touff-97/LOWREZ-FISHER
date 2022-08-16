extends Node

export(Dictionary) var game_data = {}

var path : String = "user://savedata.save"

signal has_fishes
signal out_of_fishes


func _process(delta: float) -> void:
	if fishes <= 0:
		fishes = 0
		emit_signal("out_of_fishes")
	else:
		emit_signal("has_fishes")


func save_node() -> Dictionary:
	var temp_dict := {}
	temp_dict["Player"] = {
		"fishes": fishes,
		"coins": coins
	}
	
	return temp_dict


func load_inventory() -> void:
#	var file = File.new()
#	if not file.file_exists(path):
#		return
#
#	file.open(path, File.READ)
#	var current_line = parse_json(file.get_line())
#	file.close()
	pass



func save_inventory() -> void:
	var save_game = File.new()
	save_game.open(path, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save_node")
		save_game.store_line(to_json(node_data))
	save_game.close()
