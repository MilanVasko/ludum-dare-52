extends KinematicBody2D

onready var footsteps = $Footsteps
var door_keys := {}

var health: float
var stamina: float
var stamina_regenerate_cooldown: float
var health_regenerate_cooldown: float

func _ready() -> void:
	health = Global.player_health
	stamina = Global.player_stamina_in_seconds
	stamina_regenerate_cooldown = Global.player_stamina_regenerate_cooldown
	health_regenerate_cooldown = Global.player_health_regenerate_cooldown
	get_tree().call_group("stamina_subscriber", "_on_stamina_changed", stamina)
	get_tree().call_group("health_subscriber", "_on_health_changed", health)
	Music.register_player(self)

func _hurt(amount: float) -> void:
	health -= amount
	get_tree().call_group("health_subscriber", "_on_health_changed", health)
	health_regenerate_cooldown = Global.player_health_regenerate_cooldown
	if health <= 0.0:
		die()

func die() -> void:
	get_tree().call_group("health_subscriber", "_on_player_died")

func has_door_key(door_key: String) -> bool:
	return door_keys.has(door_key)

func take_key(door_key: String) -> void:
	door_keys[door_key] = true

func _process(delta: float) -> void:
	if health_regenerate_cooldown > 0.0:
		health_regenerate_cooldown -= delta
	else:
		health = clamp(health + Global.player_health_regenerate_speed * delta, 0, Global.player_health)
		get_tree().call_group("health_subscriber", "_on_health_changed", health)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	var speed := Global.player_walk_speed
	var wants_to_run := Input.is_action_pressed("run")
	if wants_to_run && !direction.is_equal_approx(Vector2.ZERO):
		stamina = drain_stamina(stamina, delta)
		if stamina <= 0.0:
			stamina = 0.0
		else:
			speed = Global.player_run_speed
			stamina_regenerate_cooldown = Global.player_stamina_regenerate_cooldown
		get_tree().call_group("stamina_subscriber", "_on_stamina_changed", stamina)
	else:
		if stamina_regenerate_cooldown > 0.0:
			stamina_regenerate_cooldown -= delta
		else:
			stamina = regenerate_stamina(stamina, delta)
			if stamina >= Global.player_stamina_in_seconds:
				stamina = Global.player_stamina_in_seconds
			get_tree().call_group("stamina_subscriber", "_on_stamina_changed", stamina)

	var actual_speed := (direction * speed).length()
	play_footsteps(actual_speed, delta)
	turn(actual_speed, direction)
	var _ignored := move_and_slide(direction * speed)

var footstep_cooldown := 0.0

func play_footsteps(actual_speed: float, delta: float) -> void:
	if is_zero_approx(actual_speed):
		footstep_cooldown = 0.0
		return
	footstep_cooldown -= delta
	if footstep_cooldown <= 0.0:
		footstep_cooldown = 0.5 / (actual_speed / Global.player_walk_speed)
		footsteps.get_child(randi() % footsteps.get_child_count()).play()

func drain_stamina(stamina_: float, delta: float) -> float:
	return stamina_ - delta

func regenerate_stamina(stamina_: float, delta: float) -> float:
	return stamina_ + delta

func turn(actual_speed: float, direction: Vector2) -> void:
	# standing
	if direction.is_equal_approx(Vector2.ZERO):
		$AnimationPlayer.play("RESET")
		if $Front.visible:
			return
		$Right.visible = false
		$Back.visible = false
		$Front.visible = true
		return

	# walking
	$AnimationPlayer.play("Walking", -1, actual_speed / Global.player_walk_speed)
	var a = direction.angle()

	# left-down, down, right-down
	if a < PI && a > 0:
		if $Front.visible:
			return
		$Right.visible = false
		$Back.visible = false
		$Front.visible = true
		return

	# left-up, up, right-up
	if a > -PI && a < 0:
		if $Back.visible:
			return
		$Front.visible = false
		$Right.visible = false
		$Back.visible = true
		return

	# right
	if a == 0:
		if $Right.visible && $Right.scale.x > 0:
			return
		$Front.visible = false
		$Back.visible = false
		$Right.visible = true
		$Right.scale.x = abs($Right.scale.x)
		return

	# left
	if $Right.visible && $Right.scale.x < 0:
		return
	$Front.visible = false
	$Back.visible = false
	$Right.visible = true
	$Right.scale.x = -abs($Right.scale.x)
