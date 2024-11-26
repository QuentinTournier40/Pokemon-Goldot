class_name Player extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var ray_cast: RayCast2D = $RayCast2D

var isMoving: bool = false

func _ready() -> void:
	animation_tree.set("parameters/Idle/blend_position", Vector2.DOWN)
	animation_tree.set("parameters/Walk/blend_position", Vector2.DOWN)
