extends Node2D

@onready var enemies = {
	"imp": preload("res://scenes/imp.tscn"),
	"fighter": preload("res://scenes/fighter.tscn"),
	"deployer": preload("res://scenes/deployer.tscn"),
	"turret": preload("res://scenes/turret.tscn")
}

@onready var player: Area2D = $"../../Player"
@onready var spawner = $"."
@onready var parent = $"../../"

var turret_spawned = false

func spawn_turret() -> bool:
	var player_pos = player.position
	var pos = spawner.position
	if (player_pos - pos).length() <= 200 or turret_spawned:
		return false
	var instance = enemies["turret"].instantiate()
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	var theta = atan2(dy, dx)
	
	instance.postiion = pos
	instance.rotation = 0
	parent.add_child(instance)
	turret_spawned = true
	return true

func spawn(name: String) -> bool:
	var player_pos = player.position
	var pos = spawner.position
	if (player_pos - pos).length() <= 200 or turret_spawned:
		return false
	var instance = enemies[name].instantiate()
	var dx = pos.x - player_pos.x
	var dy = pos.y - player_pos.y
	var theta = atan2(dy, dx)
	
	instance.position = pos
	instance.rotation = theta
	parent.add_child(instance)
	return true
