extends Button

func _on_pressed() -> void:
	"""
	Brings user back to main menu
	"""
	var root = $"/root/"
	var world = $"/root/World"
	var main_menu = load("res://scenes/ui/main_menu.tscn")
	var instance = main_menu.instantiate()
	root.add_child(instance)
	world.queue_free()
