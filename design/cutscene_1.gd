extends VideoStreamPlayer

func _on_finished() -> void:
	get_tree().change_scene_to_file("res://stage/levels/stage_0.tscn")
	
