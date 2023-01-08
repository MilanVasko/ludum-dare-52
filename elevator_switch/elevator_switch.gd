extends Node2D

export(String) var switch_disabled_popup_id: String
export(bool) var switch_enabled: bool
var already_used := false

func _can_use() -> bool:
	return !already_used

func _use(_caller: Node2D) -> void:
	if switch_enabled:
		already_used = true
		get_tree().call_group("elevator_subscriber", "_on_elevator_open")
	else:
		get_tree().call_group("popup_subscriber", "_on_popup_show", switch_disabled_popup_id)

func _on_plug_power() -> void:
	switch_enabled = true
	refresh()

func _ready() -> void:
	refresh()

func refresh() -> void:
	$ElevatorSwitchDisabled.visible = !switch_enabled
	$ElevatorSwitchEnabled.visible = switch_enabled


