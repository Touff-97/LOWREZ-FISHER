extends Node2D

onready var scene_manager = $SceneManager
onready var audio_manager = $AudioManager
onready var gui = $GUI
onready var inventory_hud = $GUI/InventoryHUD

var game_data : Dictionary = {}


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
	
	print("main")
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -10)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), -10)
	
	inventory_hud.load_inventory(GameData.game_data["PlayerInventory"])


### SCENE GENERAL SIGNALS ###

func _on_sceneTransition(scene: String) -> void:
	scene_manager.loadScene(scene)


func _on_songTransition(song: String) -> void:
	audio_manager.loadSong(song)


func _on_soundEffect(sound: String) -> void:
	audio_manager.loadSound(sound)


func _on_toggleHud(is_hud: bool) -> void:
	print("GUI visible " + str(is_hud))
	gui.visible = is_hud


func _on_updateHud() -> void:
	inventory_hud.load_inventory(GameData.game_data["PlayerInventory"])


func _on_dayFinished() -> void:
	print("A new day")


### DATA MANAGEMENT SIGNALS ###
func _on_out_of_fishes() -> void:
	if not scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = true


func _on_has_fishes() -> void:
	if scene_manager.get_child(0).out_of_fish:
		scene_manager.get_child(0).out_of_fish = false

