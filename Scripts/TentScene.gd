extends "res://Scripts/Scene.gd"

onready var anim_player = $Background/Arm/AnimationPlayer
onready var back_button = $Margin/BackButton
onready var arm = $Background/Arm
onready var bucket = $Background/BucketShadow/Bucket

var fishes_to_enable : int
var fishes_to_disable : int
var has_enabled_arm : bool = false

signal fish_sold(at)
signal item_bought(item)


func _ready() -> void:
	randomize()
	
	arm.rect_position.x = 32
	
	fishes_to_enable = randi() % 3 + 2
	fishes_to_disable = randi() % 10 + 5
	
	emit_signal("fetch_inventory", self.get_path())
	
# warning-ignore:return_value_discarded
	connect("fish_sold", get_node("/root/Main"), "_on_fishSold")


func _process(_delta: float) -> void:
	if out_of_fish:
		print("Bucket disabled")
		bucket.disabled = true
	else:
		if fishes_to_disable > 0:
			print("Bucket enabled")
			bucket.disabled = false


func save() -> Dictionary:
	var tent_state : Dictionary = {
		"Tent": {
			"fishes_to_enable": fishes_to_enable,
			"fishes_to_disable": fishes_to_disable
		}
	}
	
	return tent_state


func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_Bucket_pressed() -> void:
	emit_signal("sound_effect", "Select")
	
	if not has_enabled_arm:
		if fishes_to_enable > 0:
			fishes_to_enable -= 1
		else:
			anim_player.play("ArmAppear")
	else:
		if fishes_to_disable > 0:
			fishes_to_disable -= 1
		else:
			anim_player.play("ArmDisappear")
	
	emit_signal("fish_sold", "Tent")


func enableArm() -> void:
	if not has_enabled_arm:
		has_enabled_arm = true


func disableArm() -> void:
	bucket.disabled = true
	has_enabled_arm = false


func _on_Bait_pressed() -> void:
	emit_signal("sound_effect", "Select")
	emit_signal("fetch_inventory", self.get_path())
	yield(get_tree(), "idle_frame")
	if inventory["coins"] > 0:
		emit_signal("item_bought", "Bunch-O-Worms")


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()
