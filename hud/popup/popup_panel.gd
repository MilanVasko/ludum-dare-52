extends Popup

export(NodePath) var timer_path: NodePath
onready var timer := get_node(timer_path)

func _on_door_used(door: Node2D) -> void:
	if door.door_id == "players_office":
		show_label($PlayersOffice)
	else:
		print("Unknown door ID: ", door.door_id)
		return

	timer.start()
	show()
	yield(timer, "timeout")
	hide()

func show_label(which: Control) -> void:
	for child in self.get_children():
		child.hide()
	which.show()
