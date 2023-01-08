extends Popup

export(NodePath) var timer_path: NodePath
onready var timer := get_node(timer_path)

func _on_popup_show(popup_id: String) -> void:
	if popup_id == "level1/players_office":
		Global.show_just_one(get_children(), $PlayersOffice)
	elif popup_id == "level1/power_on":
		Global.show_just_one(get_children(), $PowerOn)
	elif popup_id == "locked_door":
		Global.show_just_one(get_children(), $LockedDoor)
	elif popup_id == "level1/door_to_elevator_locked":
		Global.show_just_one(get_children(), $DoorToElevatorLocked)
	elif popup_id == "level1/keypad_locker_key_found":
		Global.show_just_one(get_children(), $KeypadLockerKeyFound)
	elif popup_id == "level1/elevator_switch_disabled":
		Global.show_just_one(get_children(), $ElevatorSwitchDisabled)
	elif popup_id == "level1/exit_from_first_corridor":
		Global.show_just_one(get_children(), $ExitFromFirstCorridor)
	else:
		print("Unknown popup ID: ", popup_id)
		return

	timer.start()
	show()
	yield(timer, "timeout")
	hide()
