extends Button

func _input(event: InputEvent) -> void:
	if event.is_action("space"):
		_on_pressed()

func _on_pressed() -> void:
	var root = $"/root/"
	var world = $"/root/World"
	var new_world = load("res://scenes/world/world.tscn")
	var instance = new_world.instantiate()
	root.add_child(instance)
	world.queue_free()
