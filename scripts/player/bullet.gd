extends Area2D

@onready var bullet = $"."
@onready var explosion_spawner = preload("res://scripts/helpers/spawn_explosion.gd")
const BASE_SPEED = 400
var speed = BASE_SPEED
var prev_pos = Vector2(0, 0)

func _process(delta: float) -> void:
	""" Updates bullets position """
	var theta = bullet.rotation
	prev_pos = bullet.position
	# Continues down specific angle
	bullet.position.x += speed*delta*cos(theta)
	bullet.position.y += speed*delta*sin(theta)

func _collision(_area: Area2D) -> void:
	""" Dies on collision """
	explosion_spawner.new().spawn_bullet_explosion(prev_pos, $'../')
	bullet.queue_free()
