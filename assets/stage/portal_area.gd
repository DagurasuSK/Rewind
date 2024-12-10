extends Area2D


func _on_body_entered(body: Node2D) -> void:
	StageManager.go_to_next_stage()
