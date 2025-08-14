extends CharacterBody2D

@export var speed: float = 300

@export var bullet_scene: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SHOOT"):
		print("Pucam")
		fire_gun()

func fire_gun():
	var mouse_pos := get_global_mouse_position()
	var dir := (mouse_pos - global_position).normalized()
	
	var b = bullet_scene.instantiate()
	b.global_position = global_position
	b.velocity = dir * b.speed
	get_tree().current_scene.add_child(b)

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	direction.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	velocity = direction.normalized() * speed
	move_and_slide()
	
	var mouse_pos := get_global_mouse_position()
	var dir := mouse_pos - global_position
	rotation = dir.angle() + deg_to_rad(90)
