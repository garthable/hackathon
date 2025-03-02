extends Area2D

@onready var bullet = $"."
@onready var explosion_spawner = preload("res://scripts/helpers/spawn_explosion.gd")
const BASE_SPEED = 400
var speed = BASE_SPEED
var prev_pos = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta = bullet.rotation
	prev_pos = bullet.position
	bullet.position.x += speed*delta*cos(theta)
	bullet.position.y += speed*delta*sin(theta)

func _collision(_area: Area2D) -> void:
	explosion_spawner.new().spawn_bullet_explosion(prev_pos, $'../')
	bullet.queue_free()
