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


@export var mob_scene: PackedScene

var score
var time
var is_dead: bool = false
var wait: float = 1
var SPAWN: bool = false
var round_1: bool = true
var round_2: bool = false
var round_3: bool = false

func _Title() -> void:
	print("Title")
	pass
		
func new_game() ->void:
	time = 0
	score = 0
	
func first_wave() ->void:
	if (round_1):
		TL.spawn("imp")
		TR.spawn("imp")
		BL.spawn("imp")
		BR.spawn("imp")
		round_1 = false
		round_2 = true
	
func second_wave() ->void:
	if (round_2):
		TL.spawn("fighter")
		TR.spawn("fighter")
		BL.spawn("imp")
		BR.spawn("imp")
		round_2 = false
		round_3 = true

func third_wave() ->void:
	if (round_3):
		TL.spawn("imp")
		TR.spawn("fighter")
		BL.spawn("fighter")
		BR.spawn("deployer")
		round_3 = false
		round_1 = true
		


	 
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = _Score(delta)
	if (score > 3) and (score < 6) and round_1:
		first_wave()
	if (score > 6) and (score < 12) and round_2:
		second_wave()
	if (score > 12) and (score < 24) and round_3:
		third_wave()

	pass
