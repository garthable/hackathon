extends Area2D

@onready var player = $"."
@onready var parent = $"../"
@onready var camera = $"Camera2D"
@onready var mesh = $"PlayerMesh"
@onready var col = $"PlayerCollider"
@onready var bullet = preload("res://scenes/player/bullet.tscn")
@onready var spawn_explosion = preload("res://scripts/helpers/spawn_explosion.gd")

const MAX_SPEED: float = 350.0
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
	"""
	Tracks when player can shoot.
	Returns:
		True if player can shoot
		False if player cannot shoot
	"""
	var delta_time = Time.get_ticks_msec() - start_shooting_time
	return curr_fire_rate < delta_time

func shoot_bullet() -> void:
	""" 
	Handles bullet instantiation
	"""
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
	spawn_explosion.new().spawn_muzzle_flash(Vector2(15, 0), $".")

func go_up(delta: float) -> void:
	"""
	Makes player go up, shoot, and slow down.
	Args:
		delta: delta time between frames
	"""
	time_firing += delta
	time_firing = min(10.0, time_firing)
	
	speed += DECELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	theta += ANGULAR_VELOCITY_POS*delta
	
	if can_shoot():
		shoot_bullet()
	
func go_down(delta: float) -> void:
	"""
	Makes player go down, and speed up.
	Args:
		delta: delta time between frames
	"""
	time_firing -= 4*delta
	time_firing = max(0, time_firing)
	
	speed += ACCELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	theta += ANGULAR_VELOCITY_NEG*delta

func _process(delta: float) -> void:
	""" 
	Handles player inputs and player movement
	"""
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
	"""
	Dies on collision, creates death menu.
	"""
	is_dead = true
	mesh.visible = false
	col.set_deferred("disabled", true)
	spawn_explosion.new().spawn_explosion(player.position, $'../')
	
	var death_menu = load('res://scenes/ui/death_screen.tscn')
	var instance: CanvasLayer = death_menu.instantiate()
	$'Camera2D'.add_child(instance)
