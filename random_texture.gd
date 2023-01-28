extends Node

export(NodePath) var target_sprite_path: NodePath
onready var target_sprite := get_node(target_sprite_path)

export(Array) var possible_textures: Array

func _ready() -> void:
	target_sprite.texture = possible_textures[randi() % possible_textures.size()]
