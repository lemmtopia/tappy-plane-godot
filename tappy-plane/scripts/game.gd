extends Node

@export var hazzard_scene : PackedScene

@export var hazzard_speed_array : Array[int] = [180, 240, 300, 360, 420]
var hazzard_speed = 180

@export var hazzard_time_array : Array[int] = [15, 14, 12, 10, 8]
var level : int = 0

var score : float = 0
var mode : String = "start"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if mode == "game":
		score += delta * 10
		$UI.update_score(score)
	elif mode == "start":
		if Input.is_action_just_pressed("tap"):
			start_game()

func start_game():
	$MusicPlayer.play()
	$UI.get_node("MessageLabel").visible = false
	$Player.start(Vector2(200, 240))
	
	level = 0
	update_level()
	
	$LevelTimer.start()
	$HazzardTimer.start()
	
	for hazzard in get_children():
		if hazzard.is_in_group("hazzard"):
			hazzard.queue_free()
	
	score = 0
	mode = "game"

func game_over():
	$MusicPlayer.stop()
	$UI.get_node("MessageLabel").visible = true
	$LevelTimer.stop()
	$HazzardTimer.stop()
	hazzard_speed = 0
	
	mode = "start"

func update_level():
	hazzard_speed = hazzard_speed_array[level]
	$UI.update_level_label(level + 1)
	
	$LevelTimer.wait_time = hazzard_time_array[level]
	
func _on_rock_timer_timeout() -> void:
	var hazzard = hazzard_scene.instantiate()
	add_child(hazzard)
	hazzard.position.x = 1500
	hazzard.position.y = randf_range(-30, 86)
	
	$HazzardTimer.wait_time = randf_range(1.8, 2.5)

func _on_player_hit() -> void:
	game_over()

func _on_level_timer_timeout() -> void:
	level += 1
	if level > 4:
		level = 4
	
	update_level()
	$LevelTimer.start()
	$LevelPlayer.play()
