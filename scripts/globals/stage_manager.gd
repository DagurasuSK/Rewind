extends Node

const STAGE_PATH = "res://stage/levels/stage_{0}.tscn"
const STAGE_END = "res://stage/end_stage.tscn"

var stage_index: int = 0 # Indíce da fase atual
var total_stages: int = DirAccess.open("res://stage/levels").get_files().size() # Total de fases
var current_stage: Node # Referência da fase atual

# Alterna para a próxima fase
func go_to_next_stage() -> void:
	stage_index += 1
	
	# Se não houver próxima fase vai para a cena final
	if stage_index > total_stages:
		_go_to_end_stage()
		Hud.pause_stopwatch()
		print("Aqui")
		return
	
	go_to_specific_stage(stage_index)

# Alterna para uma fase específica
func go_to_specific_stage(stage_number: int) -> void:
	var stage_path = STAGE_PATH.format([stage_number])
	
	if current_stage:
		current_stage.queue_free()
	
	get_tree().call_deferred("change_scene_to_file", stage_path)
	
	PlayerPosition.call_deferred("clear_position")

func go_to_first_stage() -> void:
	pass

func go_to_main_menu() -> void:
	if current_stage:
		current_stage.queue_free()
	
	get_tree().call_deferred("change_scene_to_file", "res://menu/main_menu.tscn")
	PlayerPosition.clear_position()

# Recarrega a cena atual
func reload_stage() -> void:
	get_tree().call_deferred("reload_current_scene")
	PlayerPosition.clear_position()
	Hud.add_death()

# Alterna para a acena final
func _go_to_end_stage() -> void:
	if current_stage:
		current_stage.queue_free()
		
	get_tree().call_deferred("change_scene_to_file", STAGE_END)
	PlayerPosition.clear_position()
	
