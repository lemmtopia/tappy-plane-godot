extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("default")
	await $AnimationPlayer.animation_finished
	queue_free()
