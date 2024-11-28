extends Area2D

#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var foreground_3: Sprite2D = $Foreground3
@onready var foreground_4: Sprite2D = $Foreground4
@onready var moving_grass: Sprite2D = $MovingGrass

func _ready() -> void:
	moving_grass.set_visible(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		moving_grass.set_visible(true)
		foreground_3.set_z_index(26)
		foreground_4.set_z_index(26)

func _on_body_exited(body: Node2D) -> void:
	foreground_3.set_z_index(1)
	foreground_4.set_z_index(1)
	moving_grass.set_visible(false)
