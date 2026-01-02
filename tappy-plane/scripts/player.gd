extends Area2D

signal hit

const SCREEN_HEIGHT : int = 480 

@export var speed = 350.0
@export var poof_scene : PackedScene

var velocity = Vector2.ZERO
var can_move = false

func _ready() -> void:
	$AnimatedSprite2D.stop()

func _process(delta: float) -> void:
	if not can_move:
		return
	
	if velocity.y < speed:
		velocity.y += get_gravity() * delta
	
	if Input.is_action_just_pressed("tap"):
		velocity.y = -speed
		
		var poof = poof_scene.instantiate()
		get_parent().add_child(poof)
		poof.position = position + Vector2(-5, -20)
	
	position += velocity * delta
	if position.y < 0 or position.y > SCREEN_HEIGHT:
		can_move = false
		$AnimatedSprite2D.stop()
		hit.emit()
	

func start(pos):
	can_move = true
	$AnimatedSprite2D.play()
	position = pos

func _on_area_entered(_area: Area2D) -> void:
	can_move = false
	$AnimatedSprite2D.stop()
	hit.emit()
