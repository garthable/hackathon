func spawn_explosion(position: Vector2, parent: Node):
	var instance: GPUParticles2D = load("res://scenes/explosion.tscn").instantiate()
	instance.position = position
	parent.add_child(instance)
	instance.emitting = true
