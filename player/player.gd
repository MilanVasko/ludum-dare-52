extends KinematicBody2D

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

	var _ignored := move_and_slide(direction * speed)

func drain_stamina(stamina_: float, delta: float) -> float:
	return stamina_ - delta

func regenerate_stamina(stamina_: float, delta: float) -> float:
	return stamina_ + delta
