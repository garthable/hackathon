extends Node2D

func spawn_explosion(position: Vector2, parent: Node):
	var instance: GPUParticles2D = load("res://scenes/particles/explosion.tscn").instantiate()
	instance.position = position
	parent.add_child(instance)
	instance.emitting = true

func spawn_bullet_explosion(position: Vector2, parent: Node):
	var instance: GPUParticles2D = load("res://scenes/particles/bullet_explosion.tscn").instantiate()
	instance.position = position
	parent.add_child(instance)
	instance.emitting = true

func spawn_muzzle_flash(position: Vector2, parent: Node, theta = 0.0):
	var instance: GPUParticles2D = load("res://scenes/particles/muzzle_flash.tscn").instantiate()
	instance.position = position
	instance.rotation = theta
	parent.add_child(instance)
	instance.emitting = true
