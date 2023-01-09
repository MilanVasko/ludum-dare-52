extends Node2D

export(String) var locked_with: String
export(String) var locked_popup_id: String
export(String) var unlocked_popup_id: String

func _use(caller: Node2D) -> void:
	if locked_with == "" || caller.has_door_key(locked_with):
		get_tree().call_group("popup_subscriber", "_on_popup_show", unlocked_popup_id)
		open()
	else:
		if randi() % 2 == 0:
			$Locked.play()
		else:
			$Locked2.play()
		get_tree().call_group("popup_subscriber", "_on_popup_show", locked_popup_id)

func open() -> void:
	$Opened.play()
	$CollisionShape2D.disabled = true
	$Sprite.hide()
