extends Line2D
@onready var player: CharacterBody2D = $"../.."

const MAX_POINTS :int = 30
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	add_point(get_parent().global_position)
	if points.size() > MAX_POINTS:
		remove_point(0)
	#disable_trail()

"""
func disable_trail():
	if not player.is_on_wall() and not player.is_on_floor():
		self.visible = false
	else:
		self.visible = true
"""
