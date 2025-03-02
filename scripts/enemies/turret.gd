extends Area2D

@onready var turret = $"."
@onready var mesh = $"MeshInstance2D"
@onready var col = $"CollisionShape2D"
@onready var player = $"../Player"
@onready var line = $"Line2D"
@onready var spawn_explosion = preload("res://scripts/helpers/spawn_explosion.gd")
@onready var rt = preload("res://scripts/helpers/rotate_towards.gd").new()

const FIRE_RATE: int = 3000

var time_since_fire: int = Time.get_ticks_msec()

var result = null
var point: Vector2 = Vector2(0, 0)

func shoot():
	"""
	Shoots raycast and kills whatever it hits.
	"""
	time_since_fire = Time.get_ticks_msec()
	# Triggers psuedo collision when raycast hits.
	if result:
		var node = result.collider
		if node.has_method("_collision"):
			node._collision(turret)
		var node_parent = result.collider.get_parent()
		if node_parent.has_method("_collision"):
			node_parent._collision(turret)
	
func _physics_process(_delta):
	"""
	Updates aiming and time to fire for turret.
	"""
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

func track() -> void:
	var pos: Vector2 = turret.position
	var theta: float = mesh.rotation
	var player_pos: Vector2 = player.position
	
	mesh.rotation = rt.rotate_towards(theta, pos, player_pos, 1)
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
