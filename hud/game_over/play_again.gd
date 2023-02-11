extends TextureButton

func _on_play_again_pressed() -> void:
	var err := get_tree().reload_current_scene()
	assert(err == OK)
