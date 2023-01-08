extends Node2D

export(String) var level_to_load: String

func _on_elevator_open() -> void:
	$DoorBottom.queue_free()
	$DoorTop.queue_free()

func _on_panel_used():
	var err := get_tree().change_scene(level_to_load)
	assert(err == OK)
