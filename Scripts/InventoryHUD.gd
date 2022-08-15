extends Control

onready var fish_label = $"%FishLabel"
onready var coin_label = $"%CoinLabel"


func load_inventory(fishes: int, coins: int) -> void:
	fish_label.text = "%0*d" % [3, fishes]
	coin_label.text = "%0*d" % [3, coins]
