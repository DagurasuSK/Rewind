@tool
extends Control

const WALLPAPER_PATH = "res://assets/menu/wallpaper/"
var _wallpaper: PackedStringArray = ["ryan_1.jpeg", "ryan_2.jpg", "ryan_3.jpg"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_wallpaper_index = randi_range(0, _wallpaper.size()-1)
	$Wallpaper.texture = load(WALLPAPER_PATH + _wallpaper[random_wallpaper_index])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_clock()

func _update_clock() -> void:
	var text = "{0}\n{1}".format([Time.get_time_string_from_system(), Time.get_date_string_from_system()])
	%DateLabel.text = text
