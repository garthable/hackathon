extends Button

func _on_pressed() -> void:
	var game = load("res://scenes/world.tscn")
	var instance = game.instantiate()
	var menu = $'../../../'
	var root = $'../../../../'
	root.add_child(instance)
	menu.queue_free()
