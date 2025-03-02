extends Node2D

@onready var parent = $"../"
@onready var fighter = $"."
@onready var player = $"../Player"
@onready var bullet = preload("res://scenes/enemies/enemy_bullet.tscn")
@onready var spawn_explosion = preload("res://scripts/helpers/spawn_explosion.gd")
@onready var rt = preload("res://scripts/helpers/rotate_towards.gd").new()

const SPEED: float = -70.0
var shoot: bool = false

func shoot_bullet() -> void:
	var theta: float = fighter.rotation
	var instance = bullet.instantiate()
	var offset = Vector2(
		-31*cos(theta),
		-31*sin(theta)
	)
	instance.position = fighter.position + offset
	instance.rotation = theta + randf_range(-0.15, 0.15)
	instance.speed = -instance.BASE_SPEED + SPEED
	parent.add_child(instance)
	spawn_explosion.new().spawn_muzzle_flash(Vector2(-31, 0), $".", PI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = fighter.rotation
	var pos: Vector2 = fighter.position
	var player_pos: Vector2 = player.position
	
	fighter.rotation = rt.rotate_towards(theta, pos, player_pos, 0.05)
	
	fighter.position.x += delta*SPEED*cos(theta)
	fighter.position.y += delta*SPEED*sin(theta)
	
	if shoot:
		shoot_bullet()
	
func _collision(_area: Area2D) -> void:
	spawn_explosion.new().spawn_explosion(fighter.position, $"../")
	fighter.queue_free() 

func _shoot_trigger_enter(area: Area2D) -> void:
	if area.name == "Player":
		shoot = true

func _shoot_trigger_exit(area: Area2D) -> void:
	if area.name == "Player":
		shoot = false
