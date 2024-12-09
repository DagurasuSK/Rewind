extends Node

const STAGE_PATH ="res://stage/"

var stage_index: int = 0
var total_stages: int = 2
var current_stage: Node

func go_to_next_stage() -> void:
	stage_index += 1
	
	if stage_index > total_stages:
		print_debug("Não há mais fases")
		return
	
	if current_stage:
		current_stage.queue_free()
	
	var new_scene_path = STAGE_PATH + "stage_{0}.tscn".format([stage_index])
	var new_scene = load(new_scene_path).instantiate()
	
	call_deferred("add_child", new_scene)
	set_deferred("current_stage", new_scene)


func go_to_specific_stage(stage_number: int) -> void:
	pass
