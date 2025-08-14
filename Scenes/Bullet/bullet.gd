extends Area2D

@export var speed: float = 600
@export var damage: int = 5

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	rotation = velocity.angle()

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(damage)
		self.queue_free()
