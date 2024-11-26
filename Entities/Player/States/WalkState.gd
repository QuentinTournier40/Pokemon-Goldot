extends PlayerState

const TILE_SIZE = 16
const ANIMATION_DURATION = 0.25

var input_dir = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree.set("parameters/conditions/isMoving", true)

func physics_update(delta: float) -> void:
	if player.isMoving:
		return

	if Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT
	else:
		finished.emit(IDLE)
		return

	move()

func move():
	player.animation_tree.set("parameters/Walk/blend_position", input_dir)
	
	player.ray_cast.target_position = input_dir * TILE_SIZE / 2
	player.ray_cast.force_raycast_update()
	if player.ray_cast.is_colliding():
		return

	player.isMoving = true

	var tween: Tween = create_tween()
	tween.tween_property(player, "position", player.position + input_dir * TILE_SIZE, ANIMATION_DURATION)
	tween.tween_callback(stop_moving)

func stop_moving():
	player.isMoving = false
