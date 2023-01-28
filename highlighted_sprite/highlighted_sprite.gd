extends Node

export(float) var highlight_alpha: float
export(float) var normal_alpha: float
export(float) var change_speed: float
export(NodePath) var target_sprite_path: NodePath

onready var target_sprite := get_node(target_sprite_path)
onready var target_alpha = get_highlight_color().a

func highlight() -> void:
	print("Highlighting to ", highlight_alpha)
	target_alpha = highlight_alpha

func dim() -> void:
	print("Dimming to ", normal_alpha)
	target_alpha = normal_alpha

func get_highlight_color() -> Color:
	return target_sprite.material.get_shader_param("solid_color")

func set_highlight_color(new_highlight_color: Color) -> void:
	target_sprite.material.set_shader_param("solid_color", new_highlight_color)

func set_highlight_alpha(new_alpha: float) -> void:
	var current_color := get_highlight_color()
	current_color.a = new_alpha
	set_highlight_color(current_color)

func _process(delta: float) -> void:
	set_highlight_alpha(lerp(get_highlight_color().a, target_alpha, delta * change_speed))
