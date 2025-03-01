extends CharacterBody2D

@onready var player = $"."

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
	pass
	
func go_down(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("space"):
		go_up(delta)
	else:
		go_down(delta)
