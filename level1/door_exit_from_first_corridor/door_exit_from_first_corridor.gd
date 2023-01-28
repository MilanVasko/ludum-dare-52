extends "res://door/door.gd"

func _hurt(_amount: float) -> void:
	.open()
