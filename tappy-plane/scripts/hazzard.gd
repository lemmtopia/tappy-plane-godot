extends Node2D

var speed = 180

func _ready() -> void:
	add_to_group("hazzard")

func _process(delta: float) -> void:
	speed = get_parent().hazzard_speed
	position += Vector2.LEFT * speed * delta
	
	if position.x < -100:
		
		queue_free()
