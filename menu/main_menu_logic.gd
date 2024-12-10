extends Control

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_new_game_button_pressed() -> void:
	StageManager.go_to_next_stage()
	queue_free()

func _on_options_button_pressed() -> void:
	visible = false
	%OptionsContainer.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
