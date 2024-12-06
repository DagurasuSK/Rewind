extends CharacterBody2D

const HORIZONTAL_ACCELERATION := 5.0 # Aceleração horizontal
const SPEED_AIR := 75.0 # Velocidade horizontal no ar
const MAX_SPEED := 150.0 # Velocidade máxima
const JUMP_VELOCITY := -400.0 # Velocidade do pulo
const AIR_ACCELERATION := 150.0 # Aceleração no ar
const NO_INPUT_TIME := 0.65 # Tempo que o personagem fica sem controle 
const COYOTE_TIME := 0.2  # Duração do coyote time
const GAME_DEFAULT_SPEED := 1.0

var game_slow_motion := 0.25

var speed: float:
	set(new_value):
		speed = clamp(new_value, -MAX_SPEED, MAX_SPEED)

var _no_input_tick: float = 0.0: # Tick do personagem sem controle
	set(new_value):
		_no_input_tick = clampf(new_value, 0.0, INF)

var _old_direction: float # Direção do input no frame anterior

var _can_press_jump_button: bool = false # Verifica o botão de pulo pode ser pressionado
var _can_jump: bool = false # Verifica se pode pular do chão
var _can_wall_jump: bool = false # Verifica se pode pular da parede
var _last_time_jump_pressed: float = 0 # Contador desde a última vez que o botão de pulo foi pressionado, recebe o valor de COYOTE_TIME, e aplica o pulo caso seja maior que 0

func _process(delta: float) -> void:
	_handle_effects()

func _physics_process(delta: float) -> void:
	_movement_horizontal(delta)
	_movement_vertical(delta)
	_handle_slowMotion(delta)
	move_and_slide()

#region Movimento Horizontal
func _movement_horizontal(delta) -> void:
	if _no_input_tick > 0:
		_no_input_tick -= delta
		speed = velocity.x
		if get_last_slide_collision():
			_no_input_tick = 0
		return
	
	if is_on_floor():
		_movement_ground(delta)
	else:
		_movement_air(delta)
	
func _movement_ground(delta) -> void: # Movimento horizontal do personagem no chão
	var direction := Input.get_axis("left", "right")
	speed = lerpf(speed, MAX_SPEED * direction, HORIZONTAL_ACCELERATION * delta)
	_old_direction = direction
	velocity.x = speed
	
func _movement_air(delta) -> void: # Movimento horizontal do personagem no ar
	var direction = Input.get_axis("left", "right")
	
	if direction != _old_direction and _old_direction != 0: # Se estiver pressionando uma direção diferente da direção inicial, e não estava parado no chão
		speed = lerpf(speed, speed * 0.95 , 0.5)
		if is_zero_approx(speed):
			_old_direction = direction
	
	elif _old_direction == 0 and direction: # Se estava com o eixo x parado e começou a se mvoer no ar
		speed = SPEED_AIR * direction
		_old_direction = direction
		
	else: # Se _old_direction é igual a direction
		speed = move_toward(speed, SPEED_AIR * direction, 10 * delta)
	velocity.x = speed

#endregion

#region Movimento Vertical
# Gerencia o movimento vertical do personagem e aplica gravidade caso necessário
func _movement_vertical(delta) -> void:
	# Adiciona gravidade ao personagem
	if not is_on_floor():
		if is_on_wall() and velocity.y > 0:
			velocity.y = 60
		else:
			velocity += get_gravity() * delta
	
	_check_coyote_time(delta) # Calcula as váriaveis do coyote time

	if _last_time_jump_pressed > 0:
		if _can_wall_jump:
			_wall_jump()
			_can_wall_jump = false
			_last_time_jump_pressed = 0
			
		if _can_jump:
			_jump(delta)
			_can_jump = false
			_last_time_jump_pressed = 0
			_can_press_jump_button = true

# Calcula o coyote time
func _check_coyote_time(delta: float) -> void:
	if is_on_floor(): # Se estiver no chão reseta as variáveis, quando estiver no chão não pode dar wall_jump, caso esteja encostado na parede também
		_can_press_jump_button = true
		_can_jump = true
		_can_wall_jump = false
	
	if is_on_wall_only(): # Se estiver nas paredes reseta as variáveis
		_can_press_jump_button = true
		_can_jump = true
		_can_wall_jump = true
		
	if Input.is_action_just_pressed("ui_accept") and _can_press_jump_button: # Caso o botão de pulo seja pressionado ativa o contador do coyote time
		_last_time_jump_pressed = COYOTE_TIME
		_can_press_jump_button = false
	
	if not _can_press_jump_button:
		_last_time_jump_pressed -= delta

func _jump(delta) -> void:
	velocity.y = JUMP_VELOCITY

# Aplica o wall jumpd
func _wall_jump() -> void:
	var wall_normal = get_wall_normal()
	velocity.x = wall_normal.x * MAX_SPEED
	velocity.y = JUMP_VELOCITY
	_old_direction = wall_normal.x
	_no_input_tick = NO_INPUT_TIME
	
#endregion
# Lida com os efeitos do personagem
func _handle_effects():
	if is_on_floor_only() and velocity.x != 0:
		$WalkParticles.emitting = true
	else:
		$WalkParticles.emitting = false
		

#region slowmotion
#deixa o jogo em camera lenta
func _handle_slowMotion(delta):

	if Input.is_action_pressed("slowMotion"):
		#Engine.time_scale = game_slow_motion
		Engine.time_scale = lerp(Engine.time_scale, game_slow_motion,  0.1)
	else:
		Engine.time_scale = lerp(Engine.time_scale, GAME_DEFAULT_SPEED,  0.5)
		#Engine.time_scale = GAME_DEFAULT_SPEED
#endregion
