extends Node2D

export(bool) var locked: bool
export(String) var door_id: String

func _use(_caller: Node2D) -> void:
	get_tree().call_group("door_subscriber", "_on_door_used", self)
	if !locked:
		queue_free()
