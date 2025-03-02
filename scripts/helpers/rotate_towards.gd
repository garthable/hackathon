extends Node

func rotate_towards(theta: float, pos_a: Vector2, pos_b: Vector2, t: float) -> float:
	"""
	Calculates angle to best gradually turn towards object with.
	Args:
		theta: current angle
		pos_a: position object to be rotated
		pos_b: position of target object
	Returns:
		New angle
	"""
	var dx = pos_a.x - pos_b.x
	var dy = pos_a.y - pos_b.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, t)
