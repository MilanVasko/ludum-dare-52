extends Node2D

export(bool) var locked: bool
export(String) var door_id: String

func _use(_caller: Node2D) -> void:
	get_tree().call_group("popup_subscriber", "_on_popup_show", door_id)
	if !locked:
		queue_free()
	else:
		pass#get_tree().call_group("popup")
