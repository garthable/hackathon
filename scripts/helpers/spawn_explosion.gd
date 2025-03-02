extends Node2D

func spawn_explosion(position: Vector2, parent: Node):
	"""
	Spawns explosion particles
	Args:
		position: Where to spawn particles
		parent: Parent of particles
	"""
	var instance: GPUParticles2D = load("res://scenes/particles/explosion.tscn").instantiate()
	instance.position = position
	parent.add_child(instance)
	instance.emitting = true

func spawn_bullet_explosion(position: Vector2, parent: Node):
	"""
	Spawns bullet explosion particles
	Args:
		position: Where to spawn particles
		parent: Parent of particles
	"""
	var instance: GPUParticles2D = load("res://scenes/particles/bullet_explosion.tscn").instantiate()
	instance.position = position
	parent.add_child(instance)
	instance.emitting = true

func spawn_muzzle_flash(position: Vector2, parent: Node, theta = 0.0):
	"""
	Spawns explosion particles
	Args:
		position: Where to spawn particles
		parent: Parent of particles
		theta: Angle of particles
	"""
	var instance: GPUParticles2D = load("res://scenes/particles/muzzle_flash.tscn").instantiate()
	instance.position = position
	instance.rotation = theta
	parent.add_child(instance)
	instance.emitting = true
