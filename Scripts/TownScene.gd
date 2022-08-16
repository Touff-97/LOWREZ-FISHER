extends "res://Scripts/Scene.gd"

onready var back_button = $Margin/BackButton
onready var background = $Background
onready var skybox = $SkyBox
onready var tween = $Tween
onready var anim_player = $NewDay/AnimationPlayer
onready var town_label = $Margin/ToTown2Label

var town_size : int = 128
var town_scenes : int = 2
var shift_amount : int = 32

var starting_position : int = -32
var left_boundary : int
var right_boundary : int


func _ready() -> void:
	left_boundary = starting_position + ((town_size / 2) - shift_amount)
	right_boundary = starting_position - ((town_size / 2) - shift_amount)


func _process(delta: float) -> void:
	if background.rect_position.x > left_boundary:
		background.rect_position.x = left_boundary
	
	if background.rect_position.x < right_boundary:
		background.rect_position.x = right_boundary


func _on_mouse_entered() -> void:
	emit_signal("sound_effect", "Hover")


func _on_goToButton_mouse_entered(direction: String) -> void:
	if not find_node(direction + "Button").disabled:
		emit_signal("sound_effect", "Hover")
		match direction:
			"Left":
				if background.rect_position.x < left_boundary:
					print(tween.interpolate_property(background, "rect_position", null, \
											Vector2(background.rect_position.x + shift_amount, 0), 0.25, \
											Tween.TRANS_LINEAR, Tween.EASE_OUT, 0))
			
			"Right":
				if background.rect_position.x > right_boundary:
					print(tween.interpolate_property(background, "rect_position", null, \
											Vector2(background.rect_position.x - shift_amount, 0), 0.25, \
											Tween.TRANS_LINEAR, Tween.EASE_OUT, 0))
	else:
		return
	tween.start()


func _on_goToButton_mouse_exited(direction: String) -> void:
	if not find_node(direction + "Button").disabled:
		match direction:
			"Left":
				print(tween.interpolate_property(background, "rect_position", null, \
											Vector2(background.rect_position.x - shift_amount, 0), 0.25, \
											Tween.TRANS_LINEAR, Tween.EASE_OUT, 0))
			
			"Right":
				print(tween.interpolate_property(background, "rect_position", null, \
											Vector2(background.rect_position.x + shift_amount, 0), 0.25, \
											Tween.TRANS_LINEAR, Tween.EASE_OUT, 0))
	else:
		if direction == "Left" and background.rect_position.x == left_boundary:
			return
		elif direction == "Right" and background.rect_position.x == right_boundary:
			return
		else:
			find_node(direction + "Button").disabled = false
	
	tween.start()


func _on_goToButton_pressed(direction: String) -> void:
	emit_signal("sound_effect", "Select")
	
	find_node(direction + "Button").disabled = true
	match direction:
		"Left":
			find_node("RightButton").disabled = false
		
		"Right":
			find_node("LeftButton").disabled = false


func _on_BackButton_pressed() -> void:
	emit_signal("sound_effect", "Select")
	next_scene = back_button.next_scene
	transitionToScene()


func _on_ToFishing_pressed() -> void:
	emit_signal("sound_effect", "Select")
	
	skybox.set_physics_process(false)
	
	next_scene = "Town1BeachScene"
	transitionToScene()


func _on_ToTent_pressed() -> void:
	emit_signal("sound_effect", "Select")
	
	skybox.set_physics_process(false)
	
	next_scene = "TentScene"
	transitionToScene()


func _on_ToTown2_pressed() -> void:
	town_label.visible = true
	yield(get_tree().create_timer(1.0), "timeout")
	town_label.visible = false
#
#
#func _on_day_finished() -> void:
#	anim_player.play("Fade")
#
#
#func wakeUp() -> void:
#	rect_position.x = starting_position
