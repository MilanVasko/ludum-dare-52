extends Label

func _ready() -> void:
	hide()

func _on_usable_object_entered(_obj: Node2D) -> void:
	show()

func _on_usable_object_exited(_obj: Node2D) -> void:
	hide()
