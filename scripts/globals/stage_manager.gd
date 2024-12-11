extends Node

const STAGE_PATH = "res://stage/stage_{0}.tscn"
const STAGE_END = "res://stage/end_stage.tscn"

var stage_index: int = 0
var total_stages: int = DirAccess.open("res://stage").get_files().size() - 1
var current_stage: Node

func go_to_next_stage() -> void:
	stage_index += 1
	
	if stage_index > total_stages:
		_go_to_end_stage()
		return
	
	go_to_specific_stage(stage_index)


func go_to_specific_stage(stage_number: int) -> void:
	var stage_path = STAGE_PATH.format([stage_number])
	
	if current_stage:
		current_stage.queue_free()
	
	get_tree().call_deferred("change_scene_to_file", stage_path)
	
	PlayerPosition.call_deferred("clear_position")

func go_to_first_stage() -> void:
	pass

func go_to_main_menu() -> void:
	pass

func reload_stage() -> void:
	get_tree().call_deferred("reload_current_scene")
	PlayerPosition.clear_position()

func _go_to_end_stage() -> void:
	if current_stage:
		current_stage.queue_free()
		
	get_tree().call_deferred("change_scene_to_file", STAGE_END)
	
