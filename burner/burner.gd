extends Area2D

func _ready() -> void:
	$Result.visible = false
	$Result/HurtArea.monitoring = false

func _can_use() -> bool:
	return get_node("/root/Game")._can_use_burner()

func _use(caller: Node2D) -> void:
	if get_node("/root/Game")._use_burner(self, caller):
		$Result.visible = true
		$Result/HurtArea.monitoring = true
