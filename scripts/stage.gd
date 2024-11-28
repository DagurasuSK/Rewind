extends Node2D

@export var player: CharacterBody2D
var enemy_arr: Array[PathFollow2D]

var enemy_path: Path2D # Caminho que o inimigo segue, os pontos são a posição do jogador
var spawn_timer: float = 5.0:
	set(new_value):
		spawn_timer = clampf(new_value, 0.5, INF)

var spawn_tick: float = 0.0

func _ready() -> void:
	enemy_path = Path2D.new() # Cria o caminho do inimigo
	enemy_path.curve = Curve2D.new() # Cria a curva do caminho do inimigo
	
	var new_enemy = preload("res://Assets/enemy/enemy.tscn").instantiate()
	enemy_arr.append(new_enemy) # Instância o inimigo
	
	add_child(enemy_path) # Adiciona o caminho na cena
	enemy_path.add_child(new_enemy) # Adiciona o inimigo como filho do caminho
	
	enemy_path.curve.add_point(player.global_position - Vector2(50, 0))
	
func _physics_process(delta: float) -> void:
	if player:
			
		if enemy_path.curve.get_baked_points()[-1].distance_to(player.global_position) > 0: # Adiciona pontos a curva caso o personagem esteja se movendo
			enemy_path.curve.add_point(player.global_position)
	
	for enemy in enemy_arr:
		enemy.progress_ratio += 0.1 * delta # Movimenta o inimigo no caminho

	spawn_tick += delta
	if spawn_tick >= spawn_timer:
		spawn_enemy()
		spawn_tick = 0
		spawn_timer -= 0.3

# Spawna um novo inimigo e adiciona no array de inimigos
func spawn_enemy():
	var new_enemy = preload("res://Assets/enemy/enemy.tscn").instantiate()
	enemy_arr.append(new_enemy)
	enemy_path.add_child(new_enemy)
