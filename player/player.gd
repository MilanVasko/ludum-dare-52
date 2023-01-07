extends KinematicBody2D

var speed := 200

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	var _ignored := move_and_slide(direction * speed)
