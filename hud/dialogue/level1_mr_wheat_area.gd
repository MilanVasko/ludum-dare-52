extends "res://hud/dialogue/specific_dialogue.gd"

func _on_dialogue_end() -> void:
	get_tree().call_group("enemy", "_activate")
