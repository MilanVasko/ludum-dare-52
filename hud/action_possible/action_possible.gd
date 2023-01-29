extends Control

func _ready() -> void:
	$Text.add_color_override("font_color", Color(0, 0, 0))
	hide()

func _on_usable_object_entered(_obj: Node2D) -> void:
	show()

func _on_usable_object_exited(_obj: Node2D) -> void:
	hide()
