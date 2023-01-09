extends Node

onready var drums_calm := $DrumsCalm
onready var drums_intense := $DrumsIntense
onready var guitar_calm1 := $GuitarCalm1
onready var guitar_calm2 := $GuitarCalm2

const MAX_DB = 0.0
const MIN_DB = -30.0
const DISTANCE_THRESHOLD = 700.0

var current_player: Node2D
var current_enemy: Node2D
var target_intensity := 0.0
var current_intensity := target_intensity

func _ready() -> void:
	target_intensity = 0.0
	set_intensity(current_intensity)

func _process(delta: float) -> void:
	if !is_instance_valid(current_enemy) || !is_instance_valid(current_player):
		return
	if current_enemy.is_chasing_us():
		target_intensity = 1.0
	else:
		var current_distance := current_enemy.global_position.distance_to(current_player.global_position)
		target_intensity = 1.0 - clamp(current_distance / DISTANCE_THRESHOLD, 0.0, 1.0)
	
	set_intensity(lerp(current_intensity, target_intensity, delta))

func set_intensity(intensity: float) -> void:
	current_intensity = intensity
	var bus_intense := AudioServer.get_bus_index("MusicIntenseInput")
	var bus_calm := AudioServer.get_bus_index("MusicCalmInput")
	AudioServer.set_bus_volume_db(bus_intense, lerp(MIN_DB, MAX_DB, intensity))
	AudioServer.set_bus_volume_db(bus_calm, lerp(MIN_DB, MAX_DB, 1.0 - intensity))
	#drums_intense.volume_db = lerp(MIN_DB, MAX_DB, intensity)
	#guitar_calm1.volume_db = lerp(MIN_DB, MAX_DB, intensity)

	#drums_calm.volume_db = lerp(MIN_DB, MAX_DB, 1.0 - intensity)
	#guitar_calm2.volume_db = lerp(MIN_DB, MAX_DB, 1.0 - intensity)

func register_player(player: Node2D) -> void:
	current_player = player

func register_enemy(enemy: Node2D) -> void:
	current_enemy = enemy
