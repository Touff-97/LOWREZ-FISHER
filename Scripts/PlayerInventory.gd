extends Node

export(Dictionary) var inventory = {
	"fishes": 0,
	"coins": 0,
}

signal has_fishes
signal out_of_fishes


func _process(delta: float) -> void:
	if inventory["fishes"] <= 0:
		inventory["fishes"] = 0
		emit_signal("out_of_fishes")
	else:
		emit_signal("has_fishes")


func save_node() -> Dictionary:
	var temp_dict := {}
	temp_dict[get_name()] = inventory
	return temp_dict


func load_node(data: Dictionary) -> void:
	print("Player inventory loaded!")
	inventory = data
