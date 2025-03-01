extends Area2D

@onready var bullet = $"."
const BASE_SPEED = 400
var speed = BASE_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta = bullet.rotation
	bullet.position.x += speed*delta*cos(theta)
	bullet.position.y += speed*delta*sin(theta)

func _collision(_area: Area2D) -> void:
	bullet.queue_free()
