extends Button

func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()
