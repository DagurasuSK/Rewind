extends Node2D

var enemy_arr: Array[CharacterBody2D]

var spawn_timer: float = 1.0:
	set(new_value):
		spawn_timer = clampf(new_value, 0.5, INF)

var spawn_tick: float = 0.0

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	spawn_enemy()

func _physics_process(delta: float) -> void:
	spawn_tick += delta
	if spawn_tick >= spawn_timer:
		spawn_enemy()
		spawn_tick = 0
		spawn_timer -= 0.3

# Spawna um novo inimigo e adiciona no array de inimigos
func spawn_enemy():
	var new_enemy = preload("res://Assets/enemy/enemy.tscn").instantiate()
	enemy_arr.append(new_enemy)
	add_child(new_enemy)
