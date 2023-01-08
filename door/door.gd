extends Node2D

export(bool) var locked: bool
export(String) var locked_popup_id: String
export(String) var unlocked_popup_id: String

func _use(_caller: Node2D) -> void:
	if !locked:
		get_tree().call_group("popup_subscriber", "_on_popup_show", unlocked_popup_id)
		queue_free()
	else:
		get_tree().call_group("popup_subscriber", "_on_popup_show", locked_popup_id)
