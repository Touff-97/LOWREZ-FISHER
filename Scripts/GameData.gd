extends Node

const path = "user://savegame.save"

# Player Inventory
export(int) var fishes = 0
export(int) var coins = 0
export(int) var worms = 0
# Tent
export(int) var fishes_to_enable = 0
export(int) var fishes_to_disable = 0

export(Dictionary) var game_data = {
									"Time": Time.get_date_dict_from_system(),
									"PlayerInventory": {
										"fishes": fishes,
										"coins": coins,
										"worms": worms,
									},
									"TentScene": {
										"fishes_to_enable": fishes_to_enable,
										"fishes_to_disable": fishes_to_disable
									}
								}

signal has_fishes
signal out_of_fishes


func _ready() -> void:
	print("game data")
	load_game()


func _process(_delta: float) -> void:
	if fishes <= 0:
		fishes = 0
		emit_signal("out_of_fishes")
	else:
		emit_signal("has_fishes")


func _on_SaveTimer_timeout() -> void:
	save_game()


func save_game() -> void:
	var save_game = File.new()
	save_game.open(path, File.WRITE)
	save_game.store_line(to_json(game_data))
	save_game.close()


func load_game() -> void:
	var save_game = File.new()
	if not save_game.file_exists(path):
		return
	save_game.open(path, File.READ)
	while not save_game.eof_reached():
		var save_game_data = parse_json(save_game.get_as_text())
		if save_game_data != null:
			game_data = save_game_data
	save_game.close()
	
	load_variables()


func load_variables() -> void:
	var current_time = Time.get_date_dict_from_system()
	
	# Time sensitive data
	if game_data["Time"]["hour"] != current_time["hour"] and game_data["Time"]["day"] != current_time["day"]:
		# Tent Scene
		fishes_to_enable = randi() % 3 + 2
		fishes_to_disable = randi() % 10 + 5
	else:
		# Tent Scene
		fishes_to_enable = game_data["TentScene"]["fishes_to_enable"]
		fishes_to_disable = game_data["TentScene"]["fishes_to_disable"]
	
	# Player Inventory
	fishes = game_data["PlayerInventory"]["fishes"]
	coins = game_data["PlayerInventory"]["coins"]
	worms = game_data["PlayerInventory"]["worms"]
