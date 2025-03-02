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

func _Title() -> void:
	print("Title")
	pass
		
func new_game() ->void:
	time = 0
	score = 0

	 
func _Score(delta: float) -> float:
	time += 1
	if time%100 == 0:
		score += 1
		print(score)
	return score
	
func _OpenTunnel() -> void:
	pass
	
	
func _ready() -> void:
	new_game()
	pass # Replace with function body.

func spawn_mob(name: String) -> bool:
	for i in range(4):
		index = (index + 1) % 4
		if spawners[index].spawn(name):
			return true
			
	return false

var prev_score = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prev_score = score
	score = int(_Score(delta))
	if prev_score != score:
		if score % 3 == 0 or score % 2 == 0:
			imps_to_spawn += 1
		elif score % 3 == 1 or score % 4 == 0:
			fighters_to_spawn += 1
		else:
			deployer_to_spawn += 1
	if imps_to_spawn > 0 and spawn_mob("imp"):
		imps_to_spawn -= 1
	if fighters_to_spawn > 0 and spawn_mob("fighter"):
		fighters_to_spawn -= 1
	if deployer_to_spawn > 0 and spawn_mob("deployer"):
		deployer_to_spawn -= 1
	pass
