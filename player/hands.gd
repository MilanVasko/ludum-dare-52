extends Area2D

export(NodePath) var player_path
onready var player := get_node(player_path)
var close_usable_object: Node2D = null

func _process(_delta: float) -> void:
	if close_usable_object == null || !Input.is_action_just_pressed("use"):
		return

	if can_use(close_usable_object):
		close_usable_object._use(player)
	else:
		_on_object_exited(close_usable_object)

func _on_object_entered(obj: Node) -> void:
	if !obj.has_method("_use") || !can_use(obj):
		return

	if close_usable_object != null:
		_on_object_exited(close_usable_object)

	close_usable_object = obj
	if obj.has_method("_on_player_entered"):
		obj._on_player_entered()

	get_tree().call_group("usable_object_subscriber", "_on_usable_object_entered", obj)

func _on_object_exited(obj: Node) -> void:
	if close_usable_object != obj:
		return

	close_usable_object = null
	if obj.has_method("_on_player_exited"):
		obj._on_player_exited()

	get_tree().call_group("usable_object_subscriber", "_on_usable_object_exited", obj)

func can_use(obj) -> bool:
	return !obj.has_method("_can_use") || obj._can_use()
