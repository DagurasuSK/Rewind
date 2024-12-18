extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	Hud.pause_stopwatch()
	MusicManager.stop()
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
