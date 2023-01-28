extends Area2D

export(String) var popup_id: String
var already_used := false

func _on_player_entered() -> void:
	$Off.highlight()
	$On.highlight()

func _on_player_exited() -> void:
	$Off.dim()
	$On.dim()

func _can_use() -> bool:
	return !already_used

func _use(_called: Node) -> void:
	already_used = true
	get_tree().call_group("power_subscriber", "_on_plug_power")
	get_tree().call_group("popup_subscriber", "_on_popup_show", popup_id)
	$Off.visible = false
	$On.visible = true
	$Noise.play()
