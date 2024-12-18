extends AudioStreamPlayer

var _menu_music_path = "res://effects/music/Cronos.mp3"
var _gameplay_music_path = "res://effects/music/let's get technical.mp3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus = "Music"
	
func play_menu_music() -> void:
	stream = load(_menu_music_path)
	stream.loop = true
	play()

func play_gameplay_music() -> void:
	stream = load(_gameplay_music_path)
	stream.loop = true
	volume_db = -15
	play()
	
