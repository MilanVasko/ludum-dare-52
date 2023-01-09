extends Node2D

export(float) var min_rotation: float
export(float) var max_rotation: float
export(float) var min_scale: float
export(float) var max_scale: float
export(float) var min_rotation_speed: float
export(float) var max_rotation_speed: float
var rotate_to_min: bool

var current_rotation_speed: float

func _ready() -> void:
	rotate_to_min = randi() % 2 == 0
	scale = Vector2.ONE * rand_range(min_scale, max_scale)
	current_rotation_speed = rand_range(min_rotation_speed, max_rotation_speed)

func _process(delta: float) -> void:
	if rotate_to_min:
		rotation_degrees -= current_rotation_speed * delta
		if rotation_degrees <= min_rotation:
			rotate_to_min = !rotate_to_min
			current_rotation_speed = rand_range(min_rotation_speed, max_rotation_speed)
	else:
		rotation_degrees += current_rotation_speed * delta
		if rotation_degrees >= max_rotation:
			rotate_to_min = !rotate_to_min
			current_rotation_speed = rand_range(min_rotation_speed, max_rotation_speed)
