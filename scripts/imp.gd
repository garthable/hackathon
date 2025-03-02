extends Area2D

@onready var imp = $"."
@onready var player = $"../Player"

const SPEED: float = -300.0

func rotate_towards(theta: float, pos: Vector2, player_pos: Vector2) -> float:
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, 0.025)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = imp.rotation
	var pos: Vector2 = imp.position
	var player_pos: Vector2 = player.position
	
	imp.rotation = rotate_towards(theta, pos, player_pos)
	
	imp.position.x += delta*SPEED*cos(theta)
	imp.position.y += delta*SPEED*sin(theta)


func _collision(area: Area2D) -> void:
	imp.queue_free()
