extends Node

func _ready() -> void:
	get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/start")

var burner_used := false

func _can_use_burner() -> bool:
	return !burner_used

func _use_burner(_burner: Node2D, _caller: Node2D) -> void:
	var enemy := $Entities/Enemy
	if !enemy.is_activated():
		get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/burner_intro")
	else:
		enemy.scare()
		burner_used = true
