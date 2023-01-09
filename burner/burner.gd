extends Area2D

func _can_use() -> bool:
	return get_node("/root/Game")._can_use_burner()

func _use(caller: Node2D) -> void:
	get_node("/root/Game")._use_burner(self, caller)
