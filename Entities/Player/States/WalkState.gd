extends PlayerState

const TILE_SIZE = 16
const ANIMATION_DURATION = 0.35

var input_dir = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	pass

func physics_update(delta: float) -> void:
	if int(player.position[0]) % 16 != 0 or int(player.position[1]) % 16 != 0:
		return
	
	if Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN
		player.animated_sprite.play("walk_down")
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
		player.animated_sprite.play("walk_up")
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		player.animated_sprite.flip_h = true
		player.animated_sprite.play("walk_horizontal")
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT
		player.animated_sprite.flip_h = false
		player.animated_sprite.play("walk_horizontal")
	else:
		finished.emit(IDLE)
		
	move()
	player.move_and_slide()
#
func move():
	if not player.isMoving:
		player.isMoving = true
		
		var tween: Tween = create_tween()
		tween.tween_property(player, "position", player.position + input_dir * TILE_SIZE, ANIMATION_DURATION)
		tween.tween_callback(moving_false)

func moving_false():
	player.animated_sprite.pause()
	player.isMoving = false
