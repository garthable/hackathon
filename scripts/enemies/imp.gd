extends Area2D

@onready var imp = $"."
@onready var player = $"../Player"
@onready var spawn_explosion = preload("res://scripts/helpers/spawn_explosion.gd")
@onready var rt = preload("res://scripts/helpers/rotate_towards.gd").new()

const SPEED: float = -300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = imp.rotation
	var pos: Vector2 = imp.position
	var player_pos: Vector2 = player.position
	
	imp.rotation = rt.rotate_towards(theta, pos, player_pos, 0.025)
	
	imp.position.x += delta*SPEED*cos(theta)
	imp.position.y += delta*SPEED*sin(theta)


func _collision(_area: Area2D) -> void:
	spawn_explosion.new().spawn_explosion(imp.position, $'../')
	imp.queue_free()
