class_name Enemy
extends CharacterBody2D

var _position_index: int = 0  # Índice da posição atual
var _target_position: Vector2  # Posição-alvo atual

var _position_time: float = 0.0  # Tempo acumulado para alcançar o alvo
var _position_ratio: float = 0.0:  # Proporção do tempo atual (0 a 1)
	set(new_value):
		_position_ratio = clamp(new_value, 0.0, 1.0)

func _ready() -> void:
	if PlayerPosition.position_arr.size() > 0:
		global_position = PlayerPosition.position_arr[0]
		_position_index = 1  # Começa a seguir o próximo ponto
		if PlayerPosition.position_arr.size() > 1:
			_set_next_target()

func _physics_process(delta: float) -> void:
	_movement(delta)

func _movement(delta: float) -> void:
	if _position_index >= PlayerPosition.position_arr.size():
		return  # Sem mais posições para seguir

	# Atualiza a proporção com base no tempo
	_position_time += delta
	_position_ratio = _position_time / PlayerPosition.STEP_TIME

	# Interpola entre a posição atual e o alvo
	global_position = global_position.lerp(_target_position, _position_ratio)

	# Verifica se completou o caminho até a posição-alvo
	if _position_ratio == 1.0:
		_set_next_target()
		_position_time = 0.0

# Atualiza a posição-alvo para o próximo valor da do array de posições
func _set_next_target() -> void:
	if _position_index > PlayerPosition.position_arr.size():
		return  # Sem mais alvos para seguir

	# Atualiza o índice e a posição-alvo
	_position_index += 1
	_target_position = PlayerPosition.position_arr[_position_index]

func _on_area_2d_body_entered(_body: Node2D) -> void:
	StageManager.reload_stage()
