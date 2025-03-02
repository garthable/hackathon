extends Node

func rotate_towards(theta: float, pos_a: Vector2, pos_b: Vector2, t: float) -> float:
	var dx = pos_a.x - pos_b.x
	var dy = pos_a.y - pos_b.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, t)
