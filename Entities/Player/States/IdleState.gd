extends PlayerState

var buffer : float = 0.0
var max_buffer : float = 0.15
var is_turning: bool = false
var target_direction: Vector2 = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree.set("parameters/Idle/blend_position", player.direction)
	player.animation_tree.set("parameters/conditions/isIdling", true)

func physics_update(_delta: float) -> void:
	var input_dir = player.get_input_direction()

	if input_dir == Vector2.ZERO:
		return

	if is_turning:
		handle_turning(_delta)
		return

	if player.direction == input_dir:
		finished.emit(WALK)
		return

	start_turning(input_dir)

func exit() -> void:
	player.animation_tree.set("parameters/conditions/isIdling", false)

func handle_turning(_delta: float) -> void:
	buffer += _delta
	if buffer >= max_buffer:
		complete_turn()
	else:
		update_turn_animation()

func complete_turn() -> void:
	player.direction = target_direction
	buffer = 0.0
	is_turning = false
	target_direction = Vector2.ZERO

func start_turning(input_dir: Vector2) -> void:
	target_direction = input_dir
	buffer = 0.0
	is_turning = true
	update_turn_animation()

func update_turn_animation() -> void:
	player.animation_tree.set("parameters/Idle/blend_position", target_direction)
