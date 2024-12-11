extends Control

func _ready() -> void:
	pass # Replace with function body.

func _on_new_game_button_pressed() -> void:
	StageManager.go_to_next_stage()
	Stopwatch.play()

func _on_options_button_pressed() -> void:
	visible = false
	%OptionsContainer.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
