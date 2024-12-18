extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/MarginContainer/ScoreLabel.text = "Time: %.2f\nDeaths: %d" % [Hud.time_passed, Hud.death_count]

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
