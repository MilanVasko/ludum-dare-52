extends Button

func _on_play_again_pressed() -> void:
	var err := get_tree().change_scene("res://levels/level1/level1.tscn")
	assert(err == OK)
