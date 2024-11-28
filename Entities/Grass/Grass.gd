extends Area2D

@onready var foreground_bottom: Sprite2D = $ForegroundBottom
@onready var moving_grass: Sprite2D = $MovingGrass

func _ready() -> void:
	moving_grass.set_visible(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		moving_grass.set_visible(true)
		foreground_bottom.set_z_index(26)

func _on_body_exited(body: Node2D) -> void:
	foreground_bottom.set_z_index(1)
	moving_grass.set_visible(false)
