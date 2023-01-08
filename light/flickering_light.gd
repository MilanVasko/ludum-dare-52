extends Light2D

export(Array) var colors: Array

export(float) var min_threshold_time: float
export(float) var max_threshold_time: float

var current_color_index := 0
var current_threshold_time := 0.0
var current_time := 0.0

func _process(delta: float) -> void:
	current_time += delta
	var next_index := (current_color_index + 1) % colors.size()
	if current_time >= current_threshold_time:
		current_color_index = next_index
		current_threshold_time = rand_range(min_threshold_time, max_threshold_time)
		current_time = 0.0
		return
	color = lerp(colors[current_color_index], colors[next_index], current_time / current_threshold_time)
