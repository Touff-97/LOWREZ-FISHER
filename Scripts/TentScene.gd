extends "res://Scripts/Scene.gd"

onready var anim_player = $Background/Arm/AnimationPlayer
onready var back_button = $Margin/BackButton
onready var arm = $Background/Arm
onready var bucket = $Background/BucketShadow/Bucket
onready var bait = $Background/Arm/Bait
onready var hooks = $Background/Arm/Hooks
onready var apple = $Background/Arm/Apple

var has_enabled_arm : bool = false


### TO DO ###
# 1. Load data from the save game file if just starting.
# 1.1. Check if day has passed since the data was saved.
# 1.2. If so reset the values to some new ones.
# 1.3. Maybe save in a temp file that resets each day.
# 2. At the signal for new day calculate a new value.
# 3. Overwrite the saved value


func _ready() -> void:
	randomize()
	
	arm.rect_position.x = 32
	arm.rect_size = Vector2(64, 64)


func _process(_delta: float) -> void:
	if out_of_fish:
		bucket.disabled = true
	else:
		if GameData.fishes_to_disable > 0:
			bucket.disabled = false


### SIGNALS ###

func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_Bucket_pressed() -> void:
	emit_signal("sound_effect", "Select")
	
	if not has_enabled_arm:
		if GameData.fishes_to_enable > 0:
			GameData.fishes_to_enable -= 1
		else:
			anim_player.play("ArmAppear")
	else:
		if GameData.fishes_to_disable > 0:
			GameData.fishes_to_disable -= 1
		else:
			anim_player.play("ArmDisappear")
	
	GameData.fishes -= 1
	GameData.coins += randi() % 3
	
	emit_signal("update_hud")


func _on_Bait_pressed() -> void:
	emit_signal("sound_effect", "Select")
	
	var random_amount := randi() % 3 + 1
	
	if GameData.coins > random_amount:
		GameData.worms += random_amount
		GameData.coins -= random_amount
		bait.disabled = true


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()


### FUNCTIONS ###

func enableArm() -> void:
	if not has_enabled_arm:
		has_enabled_arm = true


func disableArm() -> void:
	bucket.disabled = true
	has_enabled_arm = false
