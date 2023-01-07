extends Sprite

export(Array) var possible_textures: Array

func _ready() -> void:
	texture = possible_textures[randi() % possible_textures.size()]
