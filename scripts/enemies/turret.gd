extends Area2D

@onready var turret = $"."
@onready var mesh = $"MeshInstance2D"
@onready var col = $"CollisionShape2D"
@onready var player = $"../Player"
@onready var line = $"Line2D"
@onready var spawn_explosion = preload("res://scripts/helpers/spawn_explosion.gd")

const FIRE_RATE: int = 3000

var time_since_fire: int = Time.get_ticks_msec()

var result = null
var point: Vector2 = Vector2(0, 0)

func shoot():
	time_since_fire = Time.get_ticks_msec()
	if result:
		var node = result.collider.get_parent()
		if node.has_method("_collision"):
			result.collider.get_parent()._collision(turret)
	
func _physics_process(_delta):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var pos = turret.global_position
	var player_pos = player.global_position
	if (pos - player_pos).length() > 500:
		result = null
		return
	var query = PhysicsRayQueryParameters2D.create(pos, player_pos)
	query.collide_with_areas = true
	query.collision_mask = 0b00000000_00000000_00000000_01010101
	result = space_state.intersect_ray(query)
	
func rotate_towards(theta: float, pos: Vector2, player_pos: Vector2) -> float:
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	
	var goal_theta = atan2(dy, dx)
	
	return lerp_angle(theta, goal_theta, 1)

func track() -> void:
	var pos: Vector2 = turret.position
	var theta: float = mesh.rotation
	var player_pos: Vector2 = player.position
	
	mesh.rotation = rotate_towards(theta, pos, player_pos)
	col.rotation = mesh.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	var pos: Vector2 = turret.position
	if result:
		line.points = [Vector3.ZERO, result.position - pos]
	else:
		line.points = []
		time_since_fire = Time.get_ticks_msec()
		return
	var delta_time = Time.get_ticks_msec() - time_since_fire
	line.width = lerpf(2, 10, float(delta_time)/FIRE_RATE)
	if delta_time > FIRE_RATE:
		shoot()
	track()

func _collision(_area: Area2D) -> void:
	spawn_explosion.new().spawn_explosion(turret.position, $'../')
	turret.queue_free()
