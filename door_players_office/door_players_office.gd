extends "res://door/door.gd"

var intro_dialogue_finished := false

func _use(caller: Node2D) -> void:
	if !intro_dialogue_finished:
		intro_dialogue_finished = true
		get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/players_office_intro")
	else:
		._use(caller)
