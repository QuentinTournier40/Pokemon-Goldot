class_name Portal2D extends Area2D

@export_file("*.tscn") var next_scene_path
@export var teleport_to: Vector2 = Vector2.ZERO

func teleport(next_scene: PackedScene = load(next_scene_path)):
	var new_scene = next_scene.instantiate()

	var current_scene = get_tree().current_scene
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene
	
	current_scene.queue_free()

	teleport_player_in_new_scene(new_scene)

func teleport_player_in_new_scene(new_scene):
	var player = new_scene.find_child("Player")
	if player:
		player.global_position = teleport_to

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	teleport()
