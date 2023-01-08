extends "res://hud/dialogue/specific_dialogue.gd"

func _on_dialogue_end() -> void:
	var err := get_tree().change_scene("res://finish/finish.tscn")
	assert(err == OK)
