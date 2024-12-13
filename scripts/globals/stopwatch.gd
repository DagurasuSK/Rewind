extends Node

var timer_label: Label
var time_passed: float = 0.0
var start: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size =  get_viewport().get_visible_rect().size / 2
	
	timer_label = Label.new()
	timer_label.set_theme(load("res://themes/menu_theme.tres"))
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	timer_label.custom_minimum_size = Vector2i(40, 20)
	add_child(timer_label)
	timer_label.global_position = Vector2(viewport_size.x - 100, -viewport_size.y + 10)
	timer_label.z_index = 10

func _physics_process(delta: float) -> void:
	if start:
		time_passed += delta
		timer_label.text = "%.2f" % time_passed
		timer_label.text = timer_label.text.replace(".", ":")

func play() -> void:
	start = true

func pause() -> void:
	start = false
