extends Button

func _input(event: InputEvent) -> void:
	"""
	If space is pressed 
	"""
	if event.is_action_pressed("space"):
		_on_pressed()

func _on_pressed() -> void:
	var game = load("res://scenes/world/world.tscn")
	var instance = game.instantiate()
	var menu = $'../../../'
	var root = $'../../../../'
	root.add_child(instance)
	menu.queue_free()
