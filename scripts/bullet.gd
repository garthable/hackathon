extends Area2D

@onready var bullet = $"."
const SPEED = 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta = bullet.rotation
	bullet.position.x += SPEED*delta*cos(theta)
	bullet.position.y += SPEED*delta*sin(theta)


func _collision(_area: Area2D) -> void:
	bullet.queue_free()
