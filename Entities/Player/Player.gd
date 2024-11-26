class_name Player extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var isMoving: bool = false

func _ready() -> void:
	animated_sprite.play("walk_down", 0)
