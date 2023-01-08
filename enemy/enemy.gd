extends KinematicBody2D

export(bool) var is_activated: bool
onready var last_known_player_position := global_position

const threshold := 1.5
var player_follow_delay := -1.0
var wait_time := Global.enemy_wait_time

var points := []
var ray := Vector2.ZERO

func _ready() -> void:
	$AnimationPlayer.play("rest")

func _activate() -> void:
	is_activated = true

# TODO: find these in a better way
func find_navigation() -> Node:
	return get_node("/root/Game/Navigation2D")

func find_player() -> Node:
	return get_node("/root/Game/Entities/Player")

func can_see_player() -> bool:
	var result: Dictionary = Global.cast_ray(self, find_player().global_position)
	if !result.has("collider"):
		return false
	return Global.is_any_parent_in_group(result["collider"], "player")

func _physics_process(delta: float) -> void:
	if !is_activated:
		return

	var player_node := find_player()
	if can_see_player():
		last_known_player_position = player_node.global_position
		player_follow_delay = Global.enemy_player_follow_delay
		wait_time = Global.enemy_wait_time
		var _ignored := go_towards(last_known_player_position, Global.enemy_run_speed)
	elif player_follow_delay > 0.0:
		last_known_player_position = player_node.global_position
		player_follow_delay -= delta
		var _ignored := go_towards(last_known_player_position, Global.enemy_run_speed)
	else:
		if wait_time > 0.0:
			if go_towards(last_known_player_position, Global.enemy_run_speed):
				wait_time -= delta
				return
		else:
			var _ignored := go_towards(player_node.global_position, Global.enemy_walk_speed)

func go_towards(target_position: Vector2, speed: float) -> bool:
	var is_idle := true
	points = find_navigation().get_simple_path(global_position, target_position, true)

	if points.size() > 1:
		var distance = points[1] - global_position
		var direction = distance.normalized()
		if distance.length() > threshold || points.size() > 2:
			var _ignored := move_and_slide(direction * speed)
			is_idle = false
		else:
			var _ignored := move_and_slide(Vector2(0, 0))
		update()
	return is_idle

func _draw() -> void:
	if points.size() > 1:
		for p in points:
			draw_circle(to_local(p), 8, Color(1, 0, 0))
	# draw_line(Vector2.ZERO, to_local(find_player().global_position), Color.blue, 4.0)
