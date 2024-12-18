extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Time: %.2f\nDeaths: %d" % [Hud.time_passed, Hud.death_count]
