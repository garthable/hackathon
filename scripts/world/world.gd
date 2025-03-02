extends Node2D
# Get player
@onready var player = $"Player"

# Get spawning locations
@onready var TL= $"Spawner/TopLeft"
@onready var TM= $"Spawner/TopMiddle"
@onready var TR= $"Spawner/TopRight"
@onready var ML= $"Spawner/MiddleLeft"
@onready var MR= $"Spawner/MiddleRight"
@onready var BL= $"Spawner/BottomLeft"
@onready var BM= $"Spawner/BottomMiddle"
@onready var BR= $"Spawner/BottomRight"

# Put spawners in array
@onready var spawners = [TL, TR, BL, BR]
@onready var turret_spawners = [TM, ML, MR, BM]

var score = 0
var time = 0
var is_dead: bool = false
var wait: float = 1
var SPAWN: bool = false

var imps_to_spawn: int = 0
var fighters_to_spawn: int = 0
var deployer_to_spawn: int = 0
var turrets_to_spawn: int = 0

var index: int = 0
var turret_index: int = 0

var prev_score_time = Time.get_ticks_msec()

func _score() -> int:
	"""
	Gets how many seconds the player has been alive.
	Returns:
		int representing number of seconds passed.
	"""
	if Time.get_ticks_msec() - prev_score_time >= 1000:
		prev_score_time = Time.get_ticks_msec()
		score += 1
	return score

func spawn_turret() -> bool:
	"""
	Spawns turret at designated turret spawning spot.
	Returns:
		True if succesful
		False if spawn was blocked
	"""
	for i in range(4):
		turret_index = (turret_index + 1) % 4
		if turret_spawners[turret_index].spawn("turret"):
			return true
			
	return false

func spawn_mob(mob_name: String) -> bool:
	"""
	Spawns mob at designated turret spawning spot.
	Returns:
		True if succesful
		False if spawn was blocked
	"""
	for i in range(4):
		index = (index + 1) % 4
		if spawners[index].spawn(mob_name):
			return true
			
	return false

var prev_spawn_time: int = 0
var spawn_time: int = 5000

func _process(_delta: float) -> void:
	"""
	Updates function variables every frame.
	"""
	score = int(_score())
	if Time.get_ticks_msec() - prev_spawn_time >= spawn_time:
		prev_spawn_time = Time.get_ticks_msec()
		spawn_time = max(spawn_time / 1.03, 500)
		var roll = randi_range(0, 100)
		# Randomly selects mob to spawn, 
		# certain mobs unlock after certain 
		# scores have been reached.
		if roll <= 50 or score < 15:
			spawn_mob("imp")
		elif roll <= 70 or score < 35:
			spawn_mob("fighter")
		elif roll <= 80:
			spawn_mob("deployer")
		else:
			spawn_turret()
	pass
