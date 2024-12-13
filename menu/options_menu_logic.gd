extends VBoxContainer

func _on_back_button_pressed() -> void:
	visible = false
	%MainMenuContainer.visible = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_h_slider_value_changed(value: float) -> void:
	$SoundVolume/Label.text = "{0}%".format([value])
