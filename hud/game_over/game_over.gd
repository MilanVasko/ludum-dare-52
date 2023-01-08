extends Panel

func _ready() -> void:
	hide()

func _on_player_died() -> void:
	show()
	$PlayAgain.grab_focus()
	get_tree().paused = true
