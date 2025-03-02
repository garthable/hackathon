extends Button

func _on_pressed() -> void:
	var root = $"../../../../../../../"
	var world = $"../../../../../../"
	var main_menu = load("res://scenes/main_menu.tscn")
	var instance = main_menu.instantiate()
	root.add_child(instance)
	world.queue_free()
