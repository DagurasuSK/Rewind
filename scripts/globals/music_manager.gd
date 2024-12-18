extends AudioStreamPlayer

var song = "res://effects/music/let's get technical.mp3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus = "Music"
	
	stream = load(song)
	stream.loop = true
