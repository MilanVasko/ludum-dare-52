extends Area2D

onready var sprite := $Sprite

func _ready() -> void:
	$Result.visible = false
	$Result/HurtArea.monitoring = false

func _on_player_entered() -> void:
	sprite.highlight()

func _on_player_exited() -> void:
	sprite.dim()

func _can_use() -> bool:
	return get_node("/root/Game")._can_use_burner()

func _use(caller: Node2D) -> void:
	if get_node("/root/Game")._use_burner(self, caller):
		$Explosion.play()
		$Result.visible = true
		$Result/HurtArea.monitoring = true
