extends Light2D

export(float) var min_off_duration: float
export(float) var max_off_duration: float
export(float) var min_on_duration: float
export(float) var max_on_duration: float

var current_time: float

func _ready() -> void:
	current_time = rand_range(min_on_duration, max_on_duration)

func _process(delta: float) -> void:
	current_time -= delta
	if current_time <= 0.0:
		enabled = !enabled
		if enabled:
			current_time = rand_range(min_on_duration, max_on_duration)
		else:
			current_time = rand_range(min_off_duration, max_off_duration)
