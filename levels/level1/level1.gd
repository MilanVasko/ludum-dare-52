extends Node

func _ready() -> void:
	get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "start")
