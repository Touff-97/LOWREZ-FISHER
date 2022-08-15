extends Node2D

onready var scene_manager = $SceneManager
onready var audio_manager = $AudioManager
onready var inventory_manager = $InventoryManager
onready var gui = $GUI
onready var inventory_hud = $GUI/InventoryHUD


### TO DO ###
# 1. Sounds to the fishing scene [CHECK]
# 2. Shade the backgrounds as day progresses
# 3. Do transition from night to day
# 4. Pick music for different scenes



func _ready() -> void:
	randomize()
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), -10)
	
	inventory_manager.load_inventory()
	inventory_hud.load_inventory(inventory_manager.fishes, inventory_manager.coins)


func _on_sceneTransition(scene: String) -> void:
	scene_manager.loadScene(scene)


func _on_songTransition(song: String) -> void:
	audio_manager.loadSong(song)


func _on_soundEffect(sound: String) -> void:
	audio_manager.loadSound(sound)


func _on_toggleHud(is_hud: bool) -> void:
	print("GUI visible " + str(is_hud))
	gui.visible = is_hud


func _on_fishCaught() -> void:
	inventory_manager.fishes += 1
	inventory_manager.coins += randi() % 3 + 1
	inventory_hud.load_inventory(inventory_manager.fishes, inventory_manager.coins)


func _on_SaveTimer_timeout() -> void:
	inventory_manager.save_inventory()
