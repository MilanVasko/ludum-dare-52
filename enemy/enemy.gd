extends KinematicBody2D

export(float) var speed := 190.0

const threshold := 1.5

var points := []

func _ready() -> void:
	$AnimationPlayer.play("rest")

func _physics_process(_delta: float) -> void:
	points = get_node("/root/Game/Navigation2D").get_simple_path(global_position, get_node("/root/Game/Entities/Player").global_position, true)
	if points.size() > 1:
		var distance = points[1] - global_position
		var direction = distance.normalized()
		if distance.length() > threshold || points.size() > 2:
			var _ignored := move_and_slide(direction * speed)
		else:
			var _ignored := move_and_slide(Vector2(0, 0))
		update()

func _draw() -> void:
	if points.size() > 1:
		for p in points:
			draw_circle(p - global_position, 8, Color(1, 0, 0))
