extends Node2D

@onready var parent = $"../"
@onready var fighter = $"."
@onready var player = $"../Player"
@onready var bullet = preload("res://scenes/enemy_bullet.tscn")

const SPEED: float = -50.0
var shoot: bool = false

func shoot_bullet() -> void:
	var theta: float = fighter.rotation
	var instance = bullet.instantiate()
	var offset = Vector2(
		-31*cos(theta),
		-31*sin(theta)
	)
	instance.position = fighter.position + offset
	instance.rotation = theta
	instance.speed = -instance.BASE_SPEED + SPEED
	parent.add_child(instance)

func rotate_towards(theta: float, pos: Vector2, player_pos: Vector2) -> float:
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, 0.05)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = fighter.rotation
	var pos: Vector2 = fighter.position
	var player_pos: Vector2 = player.position
	
	fighter.rotation = rotate_towards(theta, pos, player_pos)
	
	fighter.position.x += delta*SPEED*cos(theta)
	fighter.position.y += delta*SPEED*sin(theta)
	
	if shoot:
		shoot_bullet()
	
func _collision(_area: Area2D) -> void:
	fighter.queue_free()

func _shoot_trigger_enter(area: Area2D) -> void:
	if area.name == "Player":
		shoot = true

func _shoot_trigger_exit(area: Area2D) -> void:
	if area.name == "Player":
		shoot = false
