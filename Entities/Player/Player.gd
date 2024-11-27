class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var ray_cast: RayCast2D = $RayCast2D

var is_moving: bool = false
var direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	set_blend_positions(direction)

func set_blend_positions(_direction: Vector2):
	animation_tree.set("parameters/Idle/blend_position", _direction)
	animation_tree.set("parameters/Walk/blend_position", _direction)

func get_input_direction():
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT

	return input_dir
