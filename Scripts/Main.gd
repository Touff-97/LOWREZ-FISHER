extends Node2D

onready var scene_manager = $SceneManager
onready var audio_manager = $AudioManager
onready var data_manager = $DataManager
onready var player_inv = $DataManager/PlayerInventory
onready var gui = $GUI
onready var inventory_hud = $GUI/InventoryHUD


### TO DO ###
# 1. Sounds to the fishing scene [CHECK]
# 2. Shade the backgrounds as day progresses [CHECK]
# 3. Do transition from night to day [NOPE]
# 4. Pick music for different scenes [CHECK]
# 5. Update inventory to handle more stuff to fish out of the ocean
# 6. Update inventory manager to save multiple nodes
# 7. Make the save store date time so to load the appropriate variables and randomize the rest


func _ready() -> void:
	randomize()
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), -10)
	
	data_manager.load_game()
	player_inv.load_node(data_manager.game_data["PlayerInventory"])
	inventory_hud.load_inventory(data_manager.game_data["PlayerInventory"])


### SCENE GENERAL SIGNALS ###

func _on_sceneTransition(scene: String) -> void:
	scene_manager.loadScene(scene)


func _on_songTransition(song: String) -> void:
	audio_manager.loadSong(song)


func _on_soundEffect(sound: String) -> void:
	audio_manager.loadSound(sound)


func _on_fetchInventory(origin: NodePath) -> void:
	data_manager.load_game()
	get_node(origin).inventory = player_inv.inventory


func _on_toggleHud(is_hud: bool) -> void:
	print("GUI visible " + str(is_hud))
	gui.visible = is_hud


### SCENE SPECIFIC SIGNALS ###

func _on_fishCaught() -> void:
	player_inv.inventory["fishes"] += 1
	inventory_hud.load_inventory(player_inv.inventory)


func _on_fishSold(at: String) -> void:
	match at:
		"Tent":
			player_inv.inventory["fishes"] -= 1
			player_inv.inventory["coins"] += randi() % 3
		_:
			return
	
	inventory_hud.load_inventory(player_inv.inventory)


### DATA MANAGEMENT SIGNALS ###

func _on_SaveTimer_timeout() -> void:
	data_manager.save_game()


func _on_DataManager_data_loaded(data: Dictionary) -> void:
	for i in data.keys():
		print(i)
		var save_nodes = get_tree().get_nodes_in_group("Persist")
		if save_nodes.has(i):
			print(save_nodes[save_nodes.bsearch(i)].name)
			save_nodes[save_nodes.bsearch(i)].load_node(data[i])


func _on_out_of_fishes() -> void:
	if not scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = true


func _on_has_fishes() -> void:
	if scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = false
