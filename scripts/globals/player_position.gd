extends Node

const STEP_TIME = 0.01 # Representa o tempo entre as atualizações do valor de position_arr

var position_arr: Array[Vector2]

func add_position(new_position: Vector2):
	position_arr.append(new_position)
