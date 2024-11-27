extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_tree.set("parameters/Idle/blend_position", player.animation_tree.get("parameters/Walk/blend_position"))
	player.animation_tree.set("parameters/conditions/isIdling", true)

func physics_update(_delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input != Vector2.ZERO:
		player.animation_tree.set("parameters/Idle/blend_position", input)
		finished.emit(WALK)

func exit() -> void:
	player.animation_tree.set("parameters/conditions/isIdling", false)
