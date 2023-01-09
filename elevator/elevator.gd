extends Node2D

export(String) var level_to_load: String
export(bool) var is_power_on_at_start: bool
export(bool) var is_open_at_start: bool

func _ready() -> void:
	if level_to_load == "":
		$Panel.already_used = true
	if !is_power_on_at_start:
		$WorkingLight.visible = false
	if is_open_at_start:
		_on_elevator_open()

func _on_plug_power() -> void:
	$WorkingLight.visible = true

func _on_elevator_open() -> void:
	$Beep.play()
	$Doors.play()
	remove_doors()

func remove_doors() -> void:
	$DoorBottom.queue_free()
	$DoorTop.queue_free()

func _on_panel_used():
	var err := get_tree().change_scene(level_to_load)
	assert(err == OK)
