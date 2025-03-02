extends Button


func _on_pressed() -> void:
	var root = $"../../../../../../../../"
	var world = $"../../../../../../../"
	var new_world = load("res://scenes/world.tscn")
	var instance = new_world.instantiate()
	root.add_child(instance)
	world.queue_free()
