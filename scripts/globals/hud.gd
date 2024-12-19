extends Node

var stopwatch_layer: CanvasLayer

var label: Label
var time_passed: float = 0.0
var start: bool = false

var death_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stopwatch_layer = CanvasLayer.new()
	stopwatch_layer.layer = 3
	add_child(stopwatch_layer)
	
	var viewport_size =  get_viewport().get_visible_rect().size
	
	label = Label.new()
	label.set_theme(load("res://themes/menu_theme.tres"))
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label.custom_minimum_size = Vector2i(50, 20)

	stopwatch_layer.add_child(label)
	
	label.global_position = Vector2(viewport_size.x - 80, 10)
	
func _physics_process(delta: float) -> void:
	if start:
		var text = "%.2f\nDeaths: %d"
		time_passed += delta
		label.text = text % [time_passed, death_count]
		label.text = label.text.replace(".", ":")

func play_stopwatch() -> void:
	start = true

func pause_stopwatch() -> void:
	start = false
	
func add_death() -> void:
	death_count += 1

func hide():
	label.visible = false

func reset_progress():
	time_passed = 0.0
	death_count = 0
