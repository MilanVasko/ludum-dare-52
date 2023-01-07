extends Popup

export(NodePath) var timer_path: NodePath
onready var timer := get_node(timer_path)

func _on_door_used(door: Node2D) -> void:
	if door.door_id == "players_office":
		Global.show_just_one(get_children(), $PlayersOffice)
	else:
		print("Unknown door ID: ", door.door_id)
		return

	timer.start()
	show()
	yield(timer, "timeout")
	hide()
