extends ProgressBar

func _on_health_changed(new_health: float) -> void:
	ratio = new_health / Global.player_health
