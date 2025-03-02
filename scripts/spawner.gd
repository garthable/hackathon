extends Node2D

@onready var enemies = {
	"imp": preload("res://scenes/imp.tscn"),
	"fighter": preload("res://scenes/fighter.tscn"),
	"deployer": preload("res://scenes/deployer.tscn")
}

@onready var player = $"../Player"
@onready var spawner = $"."
@onready var parent = $"../"

func spawn(name: String) -> bool:
	var player_pos = player.position
	var pos = spawner.position
	if (player_pos - pos).length() <= 200:
		return false
	var instance = enemies[name].instantiate()
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	var theta = atan2(dy, dx)
	
	instance.postiion = pos
	instance.rotation = theta
	parent.add_child(instance)
	return true
