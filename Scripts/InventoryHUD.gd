extends Control

onready var fish_label = $"%FishLabel"
onready var coin_label = $"%CoinLabel"


func load_inventory(inventory: Dictionary) -> void:
	fish_label.text = "%0*d" % [3, inventory["fishes"]]
	coin_label.text = "%0*d" % [3, inventory["coins"]]
