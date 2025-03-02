extends Area2D

@onready var missile = $"."
@onready var player = $"../Player"
@onready var spawn_explosion = preload("res://scripts/spawn_explosion.gd")

var lowering = true

const ACTIVATE_TIME: int = 2000
@onready var creation_time: int = Time.get_ticks_msec()
const LOWER_SPEED = 75

const ACCELERATION = -50
var speed = -LOWER_SPEED

func rotate_towards(theta: float, pos: Vector2, player_pos: Vector2) -> float:
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, 0.025)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = missile.rotation
	var pos: Vector2 = missile.position
	if Time.get_ticks_msec() - creation_time <= ACTIVATE_TIME:
		missile.position.x -= delta*LOWER_SPEED*sin(theta)
		missile.position.y += delta*LOWER_SPEED*cos(theta)
		return
	var player_pos: Vector2 = player.position
	lowering = false
	
	speed += delta*ACCELERATION
	speed = min(speed, 600)
	
	missile.rotation = rotate_towards(theta, pos, player_pos)
	
	missile.position.x += delta*speed*cos(theta)
	missile.position.y += delta*speed*sin(theta)


func _collision(area: Area2D) -> void:
	if area.name.substr(0, 3) == "Dep":
		return
	spawn_explosion.new().spawn_explosion(missile.position, $'../')
	missile.queue_free()
