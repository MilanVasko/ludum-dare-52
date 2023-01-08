extends Area2D

var disabled := false

func _on_object_entered(obj: Node) -> void:
	if disabled:
		return
	if obj.is_in_group("player"):
		get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "ending/greg")
		disabled = true

func _on_object_exited(_obj: Node) -> void:
	pass
