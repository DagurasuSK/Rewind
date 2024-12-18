extends Control

func _ready() -> void:
	MusicManager.play_menu_music()

func _on_new_game_button_pressed() -> void:
	StageManager.go_to_next_stage()
	Hud.play_stopwatch()
	MusicManager.play_gameplay_music()

func _on_options_button_pressed() -> void:
	visible = false
	%OptionsContainer.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
