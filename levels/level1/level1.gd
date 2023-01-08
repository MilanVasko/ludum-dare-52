extends Node

func _ready() -> void:
	get_tree().call_group("dialogue_subscriber", "_on_dialogue_start", "level1/start")
	#start_keypad_puzzle()

func start_keypad_puzzle() -> void:
	var keypad_puzzles := get_tree().get_nodes_in_group("keypad_puzzle")
	assert(keypad_puzzles.size() == 1)
	var keypad_puzzle: Node = keypad_puzzles[0]
	keypad_puzzle._on_keypad_puzzle_start()
	var err := keypad_puzzle.connect("puzzle_solved", self, "_on_puzzle_solved")
	assert(err == OK)

func _on_puzzle_solved() -> void:
	print("Yay!")
