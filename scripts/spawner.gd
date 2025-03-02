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

var inside_list = []

func spawn(name: String) -> bool:
	var player_pos = player.position
	var pos = spawner.position
	if len(inside_list):
		return false
	var instance = enemies[name].instantiate()
	
	instance.position = pos
	parent.add_child(instance)
	return true




func _on_area_entered(area: Area2D) -> void:
	inside_list.append(area)

func _on_area_exited(area: Area2D) -> void:
	print(len(inside_list))
	inside_list.remove_at(inside_list.find(area, 0))
	print(len(inside_list))
