extends TileMapLayer

@onready var collision := get_node("detector/collision")
@onready var tween := create_tween()

var exitedArea := true

func _ready() :
	assert(collision != null)
	

func _process(delta):
	collision.set_deferred("disabled",false) if exitedArea else collision.set_deferred("disabled",true)

func _on_detector_body_entered(body):
	if body is  Player :
		exitedArea = true
		
		tween = create_tween()
		tween.tween_property(self,"modulate:a",0.5, 0.5)

func _on_detector_body_exited(body):
	if body is  Player :
		exitedArea = true
		
		tween = create_tween()
		tween.tween_property(self,"modulate:a",1,0.75)
