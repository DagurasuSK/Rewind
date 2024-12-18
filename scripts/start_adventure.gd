extends Area2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	Hud.play_stopwatch()
	MusicManager.play_gameplay_music()
	StageManager.go_to_next_stage()
