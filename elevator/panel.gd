extends Area2D

var already_used := false

signal panel_used

func _on_player_entered() -> void:
	$Sprite.highlight()

func _on_player_exited() -> void:
	$Sprite.dim()

func _can_use() -> bool:
	return !already_used

func _use(_caller: Node2D) -> void:
	if !already_used:
		already_used = true
		emit_signal("panel_used")
