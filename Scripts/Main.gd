extends Node2D

onready var scene_manager = $SceneManager
onready var audio_manager = $AudioManager
onready var data_manager = $DataManager
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
	
	data_manager.load_inventory()
	inventory_hud.load_inventory(data_manager.fishes, data_manager.coins)


func _on_sceneTransition(scene: String) -> void:
	scene_manager.loadScene(scene)


func _on_songTransition(song: String) -> void:
	audio_manager.loadSong(song)


func _on_soundEffect(sound: String) -> void:
	audio_manager.loadSound(sound)


func _on_fetchInventory(origin: NodePath) -> void:
	get_node(origin).inventory = data_manager.save()


func _on_toggleHud(is_hud: bool) -> void:
	print("GUI visible " + str(is_hud))
	gui.visible = is_hud


func _on_fishCaught() -> void:
	data_manager.fishes += 1
	inventory_hud.load_inventory(data_manager.fishes, data_manager.coins)


func _on_fishSold(at: String) -> void:
	match at:
		"Tent":
			data_manager.fishes -= 1
			data_manager.coins += randi() % 3
		_:
			return
	
	inventory_hud.load_inventory(data_manager.fishes, data_manager.coins)


func _on_SaveTimer_timeout() -> void:
	data_manager.save_inventory()


func _on_InventoryManager_out_of_fishes() -> void:
	if not scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = true


func _on_InventoryManager_has_fishes() -> void:
	if scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = false
