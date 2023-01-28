extends "res://hud/dialogue/specific_dialogue.gd"

func _on_dialogue_end() -> void:
	get_tree().call_group("keypad_locker", "_on_intro_dialogue_finished")
