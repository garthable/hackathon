extends Area2D

@onready var bullet = $"."
const SPEED = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta = bullet.rotation
	bullet.position.x += SPEED*delta*cos(theta)
	bullet.position.y += SPEED*delta*sin(theta)


func _collision(_area: Area2D) -> void:
	print('hit!')
	bullet.queue_free()
