extends CharacterBody2D

@onready var player = $"."
@onready var camera = $"Camera2D"

const MAX_SPEED: float = 200.0
const MIN_SPEED: float = 50.0

const MAX_ANGULAR_VELOCITY: float = -10
const MIN_ANGULAR_VELOCITY: float = 10

const ACCELERATION: float = 1.0
const DECELERATION: float = -1.0

const ANG_ACCELERATION: float = 1.0
const ANG_DECELERATION: float = -1.0

var angular_velocity: float = 0.0

var speed: float = 0.0
var theta: float = 0.0

func go_up(delta: float) -> void:
	speed += DECELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	angular_velocity += ANG_ACCELERATION*delta
	angular_velocity = clampf(
		angular_velocity, 
		MAX_ANGULAR_VELOCITY, 
		MIN_ANGULAR_VELOCITY)
	
	theta += angular_velocity*delta
	
func go_down(delta: float) -> void:
	speed += ACCELERATION*delta
	speed = clampf(speed, MIN_SPEED, MAX_SPEED)
	
	angular_velocity += ANG_DECELERATION*delta
	angular_velocity = clampf(
		angular_velocity, 
		MAX_ANGULAR_VELOCITY, 
		MIN_ANGULAR_VELOCITY)
	
	theta += angular_velocity*delta

func _process(delta: float) -> void:
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
