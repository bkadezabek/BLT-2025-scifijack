extends CharacterBody2D

@export var textures: Array[Texture2D]  = []
@export var health_values: Array[int] = []
@export var speed_min = 100
@export var speed_max = 150

@export var player: Node2D

var rng := RandomNumberGenerator.new()
var speed := 100
var max_health := 0
var health := 0

func _ready() -> void:
	rng.randomize()
	rng.seed = Time.get_ticks_usec() * get_instance_id()
	if player == null:
		var p = get_tree().get_first_node_in_group("Player")
		if p: player = p
	pick_variant()

func _physics_process(delta: float) -> void:
	if player == null: return
	var dir := (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
	rotation = dir.angle() + deg_to_rad(90)
	
func pick_variant() -> void: 
	var i = rng.randi_range(0, textures.size() - 1)
	$Sprite2D.texture = textures[i]
	if i < health_values.size(): max_health = health_values[i]
	else: max_health = 1
	health = max_health
	speed = rng.randf_range(speed_min, speed_max)

func take_damage(amount: int) -> void:
	health = health - amount
	if health <= 0: queue_free()
