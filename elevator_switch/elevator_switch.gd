extends Node2D

export(bool) var switch_enabled: bool
var already_used_successfully := false
var dialogue_finished := false

func _can_use() -> bool:
	return !already_used_successfully

func _dialogue_finished() -> void:
	dialogue_finished = true

func _use(_caller: Node2D) -> void:
	if switch_enabled:
		already_used_successfully = true
		get_tree().call_group("elevator_subscriber", "_on_elevator_open")
	else:
		if dialogue_finished:
			get_tree().call_group("popup_subscriber", "_on_popup_show", "level1/elevator_switch_disabled")
		else:
			get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/elevator_switch_disabled_init")

func _on_plug_power() -> void:
	switch_enabled = true
	refresh()

func _ready() -> void:
	refresh()

func refresh() -> void:
	$ElevatorSwitchDisabled.visible = !switch_enabled
	$ElevatorSwitchEnabled.visible = switch_enabled


