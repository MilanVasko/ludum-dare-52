extends TextureButton

export(int) var number: int
signal key_pressed(index)

func _ready() -> void:
	$Label.text = str(number)

func _on_pressed() -> void:
	[$Press1, $Press2, $Press3, $Press4][randi() % 4].play()
	emit_signal("key_pressed", get_index())
