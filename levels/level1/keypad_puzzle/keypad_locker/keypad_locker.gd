extends Node2D

var last_caller: Node2D = null
export(String) var door_key_id: String
var already_solved := false
var dialogue_finished := false

func _on_player_entered() -> void:
	$Closed.highlight()
	$Open.highlight()

func _on_player_exited() -> void:
	$Closed.dim()
	$Open.dim()

func _can_use() -> bool:
	return !already_solved

func _use(caller: Node2D) -> void:
	last_caller = caller
	if already_solved:
		return
	start_keypad_puzzle(caller)

func _on_intro_dialogue_finished() -> void:
	dialogue_finished = true
	if last_caller != null:
		start_keypad_puzzle(last_caller)

func start_keypad_puzzle(caller: Node2D) -> void:
	if !dialogue_finished:
		get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/keypad_intro")
		return

	var keypad_puzzles := get_tree().get_nodes_in_group("keypad_puzzle")
	assert(keypad_puzzles.size() == 1)
	var keypad_puzzle: Node = keypad_puzzles[0]
	keypad_puzzle._on_keypad_puzzle_start()
	if !keypad_puzzle.is_connected("puzzle_solved", self, "_on_puzzle_solved"):
		var err := keypad_puzzle.connect("puzzle_solved", self, "_on_puzzle_solved", [caller])
		assert(err == OK)

func _on_puzzle_solved(caller: Node2D) -> void:
	already_solved = true
	$OpeningSqueak.play()
	caller.take_key(door_key_id)
	get_tree().call_group("popup_subscriber", "_on_popup_show", "level1/keypad_locker_key_found")
	$Open.visible = true
