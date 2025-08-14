extends Node

@onready var timer: Timer = $Timer

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.0
@export var outside_margin: float = 64.0
@export var player: Node2D

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	timer.wait_time = spawn_interval

func spawn_enemy():
	var e = enemy_scene.instantiate()
	e.global_position = random_offscreen_position()
	e.player = player
	add_child(e)

func random_offscreen_position() -> Vector2:
	var rect := get_viewport().get_visible_rect()
	var side = rng.randi_range(0, 3)
	if side == 0:
		return Vector2(
			rng.randf_range(rect.position.x, rect.position.x + rect.size.x),
			rect.position.y - outside_margin
		)
	elif side == 1:
		return Vector2(
			rect.position.x + rect.size.x + outside_margin,
			rng.randf_range(rect.position.y, rect.position.y + rect.size.y)
		)
	elif side == 2:
		return Vector2(
			rng.randf_range(rect.position.x, rect.position.x + rect.size.x),
			rect.position.y + rect.size.y + outside_margin
		)
	else:
		return Vector2(
			rect.position.y - outside_margin,
			rng.randf_range(rect.position.y, rect.position.y + rect.size.y),
		)
		
func _on_timer_timeout() -> void:
	spawn_enemy()
