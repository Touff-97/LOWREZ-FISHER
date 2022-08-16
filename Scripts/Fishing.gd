extends Control

onready var anim_player = $FishingRod/AnimationPlayer

var fish_appearance : int = 0

signal sound_effect(effect)
signal fish_caught


func _ready() -> void:
	randomize()
	
	fish_appearance = randi() % 15 + 5
	
	var timer = Timer.new()
	timer.name = "FishTimer"
	timer.wait_time = fish_appearance
	timer.one_shot = true
	timer.autostart = true
	timer.connect("timeout", self, "_on_fishTimer_timeout")
	add_child(timer, true)


func _on_fishTimer_timeout() -> void:
	print("Fish appeared!")
	anim_player.play("Fish")


func _on_FishButton_pressed() -> void:
	if anim_player.get_current_animation() == "Idle" or anim_player.get_current_animation() == "FishingIdle":
		anim_player.play("Cast")
		# When rod cast, start fish timer
		var time = OS.get_time()
		fish_appearance = randi() % time["minute"] + 5
		get_node("FishTimer").start(fish_appearance)
		
	if anim_player.get_current_animation() == "Fish":
		anim_player.play("Catch")
	
	if anim_player.get_current_animation() == "CatchIdle":
		emit_signal("fish_caught")
		anim_player.play("Idle")


func _on_animation_finished(anim_name: String) -> void:
	print("Finished ", anim_name)
	if anim_name == "Cast":
		anim_player.play("FishingIdle")
	elif anim_name == "Fish":
		anim_player.play("FishingIdle")
	elif anim_name == "Catch":
		anim_player.play("CatchIdle")


func in_animation_sound() -> void:
	if anim_player.get_current_animation() == "Cast":
		emit_signal("sound_effect", "Cast")
	elif anim_player.get_current_animation() == "Fish":
		emit_signal("sound_effect", "Fish")
	elif anim_player.get_current_animation() == "Catch":
		emit_signal("sound_effect", "Catch")

