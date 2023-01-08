extends Popup

export(NodePath) var timer_path: NodePath
onready var timer := get_node(timer_path)

func _on_popup_show(popup_id: String) -> void:
	if popup_id == "players_office":
		Global.show_just_one(get_children(), $PlayersOffice)
	elif popup_id == "elevator_opened":
		Global.show_just_one(get_children(), $ElevatorOpened)
	else:
		print("Unknown popup ID: ", popup_id)
		return

	timer.start()
	show()
	yield(timer, "timeout")
	hide()
