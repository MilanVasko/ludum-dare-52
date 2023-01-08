extends Popup

export(NodePath) var timer_path: NodePath
onready var timer := get_node(timer_path)

func _on_popup_show(popup_id: String) -> void:
	if popup_id == "level1/players_office":
		Global.show_just_one(get_children(), $PlayersOffice)
	elif popup_id == "level1/elevator_opened":
		Global.show_just_one(get_children(), $ElevatorOpened)
	elif popup_id == "locked_door":
		Global.show_just_one(get_children(), $LockedDoor)
	elif popup_id == "level1/door_to_elevator_locked":
		Global.show_just_one(get_children(), $DoorToElevatorLocked)
	else:
		print("Unknown popup ID: ", popup_id)
		return

	timer.start()
	show()
	yield(timer, "timeout")
	hide()
