extends Area2D

@onready var player = $"."
@onready var parent = $"../"
@onready var camera = $"Camera2D"
@onready var mesh = $"PlayerMesh"
@onready var col = $"PlayerCollider"
@onready var bullet = preload("res://scenes/bullet.tscn")

const MAX_SPEED: float = 400.0
const MIN_SPEED: float = 50.0

const MAX_ANGULAR_VELOCITY: float = 5
const MIN_ANGULAR_VELOCITY: float = -5

const ACCELERATION: float = 40.0
const DECELERATION: float = -20.0

const ANGULAR_VELOCITY_POS: float = 3
const ANGULAR_VELOCITY_NEG: float = -2

var time_firing: float = 0.0

var speed: float = 0.0
var theta: float = 0.0

var is_dead: bool = false

var start_shooting_time: int = Time.get_ticks_msec()
const FIRE_RATE: int = 1
const FIRE_RATE_INC: int = 3
var curr_fire_rate: int = 1

func can_shoot() -> bool:
	var delta_time = Time.get_ticks_msec() - start_shooting_time
	return curr_fire_rate < delta_time

func shoot_bullet() -> void:
	start_shooting_time = Time.get_ticks_msec()
	curr_fire_rate += FIRE_RATE_INC
	var instance = bullet.instantiate()
	var offset = Vector2(
		15*cos(theta),
		15*sin(theta)
	)
	instance.position = player.position + offset
	instance.rotation = theta
	instance.speed = instance.BASE_SPEED + speed
	parent.add_child(instance)

func go_up(delta: float) -> void:
	time_firing += delta
	time_firing = min(10.0, time_firing)
	
	speed += DECELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	theta += ANGULAR_VELOCITY_POS*delta
	
	if can_shoot():
		shoot_bullet()
	
func go_down(delta: float) -> void:
	time_firing -= 4*delta
	time_firing = max(0, time_firing)
	
	speed += ACCELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	theta += ANGULAR_VELOCITY_NEG*delta

func _process(delta: float) -> void:
	if is_dead:
		return
	if Input.is_action_just_pressed("space"):
		start_shooting_time = Time.get_ticks_msec()
		curr_fire_rate = FIRE_RATE
	if Input.is_action_pressed("space"):
		go_up(delta)
	else:
		go_down(delta)
	var dx = speed*delta*cos(theta)
	var dy = speed*delta*sin(theta)
	
	player.position.x += dx
	player.position.y += dy
	player.rotation = theta
	camera.rotation = -theta

func _collision(_area: Area2D) -> void:
	is_dead = true
	mesh.visible = false
	col.set_deferred("disabled", true)
	
	# Play explosion
	# continue velocity
