extends Node

export var fishes : int = 0
export var coins : int = 0

var path : String = "user://savedata.save"


func load_inventory() -> void:
	var file = File.new()
	if not file.file_exists(path):
		return
	
	file.open(path, File.READ)
	
	var current_line = parse_json(file.get_line())
	
	fishes = current_line["fishes"]
	coins = current_line["coins"]
	print(current_line)


func save() -> Dictionary:
	var inventory : Dictionary = {
		"fishes": fishes,
		"coins": coins
	}
	
	return inventory


func save_inventory() -> void:
	var file = File.new()
	file.open(path, File.WRITE)
	var save_data = save()
	file.store_line(to_json(save_data))
	file.close()
	print("Data saved at " + path)
