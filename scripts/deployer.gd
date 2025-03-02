extends Area2D

@onready var parent = $"../"
@onready var deployer = $"."
@onready var player = $"../Player"
@onready var missile = preload("res://scenes/missile.tscn")

const SPEED: float = -70.0
const FIRE_RATE: int = 2000

var time_since_fire: int = Time.get_ticks_msec()

func shoot_missile():
	time_since_fire = Time.get_ticks_msec()
	var theta: float = deployer.rotation
	var instance = missile.instantiate()
	var offset = Vector2(
		-31*cos(theta),
		-31*sin(theta)
	)
	instance.position = deployer.position + offset
	instance.rotation = theta
	parent.add_child(instance)

func rotate_towards(theta: float, pos: Vector2, player_pos: Vector2) -> float:
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, 0.025)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var theta: float = deployer.rotation
	var pos: Vector2 = deployer.position
	var player_pos: Vector2 = player.position
	
	deployer.rotation = rotate_towards(theta, pos, player_pos)
	
	deployer.position.x += delta*SPEED*cos(theta)
	deployer.position.y += delta*SPEED*sin(theta)
	
	if Time.get_ticks_msec() - time_since_fire > FIRE_RATE:
		shoot_missile()


func _collision(area: Area2D) -> void:
	if "lowering" in area and area.lowering: 
		return
	deployer.queue_free()
