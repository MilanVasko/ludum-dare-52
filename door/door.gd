extends Node2D

export(bool) var should_break_on_open: bool
export(String) var locked_with: String
export(String) var locked_popup_id: String
export(String) var unlocked_popup_id: String
onready var sprite_closed := $HighlightedSprite
onready var sprite_broken := $BrokenSprite
onready var sprite_opened := $OpenedSprite

func _on_player_entered() -> void:
	sprite_closed.highlight()

func _on_player_exited() -> void:
	sprite_closed.dim()

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
	$CollisionShape2D.disabled = true
	sprite_closed.hide()
	if should_break_on_open:
		$Broken.play()
		sprite_broken.show()
	else:
		$Opened.play()
		sprite_opened.show()
