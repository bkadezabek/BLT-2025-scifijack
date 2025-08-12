extends Area2D

@export var speed: float = 600

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	rotation = velocity.angle()

func _physics_process(delta: float) -> void:
	global_position += velocity * delta
