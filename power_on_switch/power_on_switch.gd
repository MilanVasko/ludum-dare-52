extends Area2D

export(String) var popup_id: String
var already_used := false

func _can_use() -> bool:
	return !already_used

func _use(_called: Node) -> void:
	already_used = true
	get_tree().call_group("power_subscriber", "_on_plug_power")
	get_tree().call_group("popup_subscriber", "_on_popup_show", popup_id)
	var power = get_node("/root/Game/Entities/PowerRoom/Power")
	power.get_node("Off").visible = false
	power.get_node("On").visible = true
