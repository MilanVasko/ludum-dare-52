extends ProgressBar

func _on_stamina_changed(new_stamina: float) -> void:
	ratio = new_stamina / Global.player_stamina_in_seconds
