class_name Portal2D extends Area2D

@export_file("*.tscn") var next_scene_path
@export var teleport_to: String

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func teleport(next_scene: PackedScene = load(next_scene_path)):
	var new_scene = next_scene.instantiate()

	var current_scene = get_tree().current_scene
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene

	current_scene.queue_free()

	teleport_player_in_new_scene()

func teleport_player_in_new_scene():
	var player = get_tree().current_scene.find_child("Player")
	var point = get_tree().current_scene.find_child(teleport_to)
	if player and point:
		player.global_position = point.global_position

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	call_deferred("teleport")
