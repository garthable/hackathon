extends Node2D
@onready var player = $"../Player"
@onready var start = $"../StartTimer"
@onready var score_time = $"../ScoreTimer"
@onready var spawn =  $"Spawner"

@onready var TL= $"Spawner/TopLeft"
@onready var TM= $"Spawner/TopMiddle"
@onready var TR= $"Spawner/TopRight"
@onready var ML= $"Spawner/MiddleLeft"
@onready var MR= $"Spawner/MiddleRight"
@onready var BL= $"Spawner/BottomLeft"
@onready var BM= $"Spawner/BottomMiddle"
@onready var BR= $"Spawner/BottomRight"

@onready var spawners = [TL, TR, BL, BR]
@onready var turret_spawners = [TM, ML, MR, BM]


@export var mob_scene: PackedScene

var score
var time
var is_dead: bool = false
var wait: float = 1
var SPAWN: bool = false

var imps_to_spawn: int = 0
var fighters_to_spawn: int = 0
var deployer_to_spawn: int = 0
var turrets_to_spawn: int = 0

var index: int = 0
var turret_index: int = 0

func _Title() -> void:
	pass
		
func new_game() ->void:
	time = 0
	score = 0

var prev_score_time = Time.get_ticks_msec()

func _Score(delta: float) -> float:
	if Time.get_ticks_msec() - prev_score_time >= 1000:
		prev_score_time = Time.get_ticks_msec()
		score += 1
	return score
	
func _OpenTunnel() -> void:
	pass
	
	
func _ready() -> void:
	new_game()
	pass # Replace with function body.

func spawn_turret() -> bool:
	for i in range(4):
		turret_index = (turret_index + 1) % 4
		if turret_spawners[turret_index].spawn("turret"):
			return true
			
	return false

func spawn_mob(mob_name: String) -> bool:
	for i in range(4):
		index = (index + 1) % 4
		if spawners[index].spawn(mob_name):
			return true
			
	return false

var prev_score = -1

var prev_spawn_time = 0.0
var spawn_time = 5000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prev_score = score
	score = int(_Score(delta))
	if Time.get_ticks_msec() - prev_spawn_time >= spawn_time:
		prev_spawn_time = Time.get_ticks_msec()
		spawn_time = max(spawn_time / 1.03, 500)
		var roll = randi_range(0, 100)
		if roll <= 50 or score < 15:
			spawn_mob("imp")
		elif roll <= 70 or score < 35:
			spawn_mob("fighter")
		elif roll <= 80:
			spawn_mob("deployer")
		else:
			spawn_turret()
	pass
