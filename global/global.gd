extends Node

export(float) var player_walk_speed: float
export(float) var player_run_speed: float
export(float) var player_stamina_in_seconds: float
export(float) var player_stamina_regenerate_cooldown: float
export(float) var enemy_player_follow_delay: float
export(float) var enemy_wait_time: float
export(float) var enemy_run_speed: float
export(float) var enemy_walk_speed: float

# such as tables
var SEE_THROUGH_LAYER = 0b10

func _ready() -> void:
	randomize()

func show_just_one(children: Array, which: CanvasItem) -> void:
	for child in children:
		child.hide()
	which.show()

func cast_ray(beholder: Node2D, target_global_position: Vector2) -> Dictionary:
	return beholder.get_world_2d().direct_space_state.intersect_ray(
		beholder.global_position,
		target_global_position,
		[],
		~Global.SEE_THROUGH_LAYER,
		true,
		true
	)

func is_any_parent_in_group(node: Node, group_name: String) -> bool:
	var parent := node
	while parent != null:
		if parent.is_in_group(group_name):
			return true
		parent = parent.get_parent()
	return false
