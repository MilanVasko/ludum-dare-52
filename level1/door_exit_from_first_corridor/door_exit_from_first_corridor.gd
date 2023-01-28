extends "res://door/door.gd"

var destructible := false

func _on_enemy_scared(_enemy: Node2D) -> void:
	destructible = true

func _hurt(_amount: float) -> void:
	if destructible:
		.open()
