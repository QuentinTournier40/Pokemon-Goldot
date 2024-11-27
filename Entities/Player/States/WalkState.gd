extends PlayerState

const TILE_SIZE = 16
const ANIMATION_DURATION = 0.25

var input_dir = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree.set("parameters/Walk/blend_position", player.direction)
	player.animation_tree.set("parameters/conditions/isMoving", true)

func physics_update(delta: float) -> void:
	if player.is_moving:
		return
	
	input_dir = player.get_input_direction()
	if input_dir == Vector2.ZERO:
		finished.emit(IDLE)
		return

	move()

func exit() -> void:
	player.animation_tree.set("parameters/conditions/isMoving", false)

func move():
	player.direction = input_dir
	player.animation_tree.set("parameters/Walk/blend_position", player.direction)
	
	player.ray_cast.target_position = input_dir * TILE_SIZE / 2
	player.ray_cast.force_raycast_update()
	if player.ray_cast.is_colliding():
		return

	player.is_moving = true

	var tween: Tween = create_tween()
	tween.tween_property(player, "position", player.position + player.direction * TILE_SIZE, ANIMATION_DURATION)
	tween.tween_callback(stop_moving)

func stop_moving():
	player.is_moving = false
