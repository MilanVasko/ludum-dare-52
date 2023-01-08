extends Control

export(int) var steps_to_shuffle: int
const COLS := 3

onready var grid_container := $Container/GridContainer
var empty_index: int
var initializing := true
var already_solved := false
signal puzzle_solved

func _ready() -> void:
	hide()

	initializing = true
	empty_index = -1
	var focus_grabbed := false
	for i in range(grid_container.get_child_count()):
		if is_empty(i):
			empty_index = i
		else:
			var child := grid_container.get_child(i)
			child.grab_focus()
			var err := child.connect("key_pressed", self, "_on_key_pressed")
			assert(err == OK)
			focus_grabbed = true
	assert(empty_index != -1)
	assert(focus_grabbed)

	shuffle()
	initializing = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		_on_close_pressed()

func _on_keypad_puzzle_start() -> void:
	get_tree().paused = true
	show()
	for i in range(grid_container.get_child_count()):
		if !is_empty(i):
			grid_container.get_child(i).grab_focus()
			break

func _on_close_pressed():
	get_tree().paused = false
	hide()

func _on_key_pressed(index: int) -> void:
	swap_with_empty(index)

func is_solved() -> bool:
	if !is_empty(0):
		return false
	for i in range(1, grid_container.get_child_count()):
		if grid_container.get_child(i).number != i + 1:
			return false
	return true

func is_empty(index: int) -> bool:
	return grid_container.get_child(index).name == "Empty"

func shuffle() -> void:
	var steps := steps_to_shuffle
	if steps % 2 == 0:
		steps += 1 # this way we can't have a solved puzzle at the start
	for _i in range(steps):
		shuffle_step()

func shuffle_step() -> void:
	var possible_neighbours := []
	var up := go_up(empty_index)
	if up != -1:
		possible_neighbours.push_back(up)
	var down := go_down(empty_index)
	if down != -1:
		possible_neighbours.push_back(down)
	var left := go_left(empty_index)
	if left != -1:
		possible_neighbours.push_back(left)
	var right := go_right(empty_index)
	if right != -1:
		possible_neighbours.push_back(right)
	assert(possible_neighbours.size() > 0)
	swap_with_empty(possible_neighbours[randi() % possible_neighbours.size()])

func swap_with_empty(neighbour_index: int) -> void:
	var up := go_up(neighbour_index)
	if up != -1 && is_empty(up):
		swap(neighbour_index, up)
		return
	var down := go_down(neighbour_index)
	if down != -1 && is_empty(down):
		swap(neighbour_index, down)
		return
	var left := go_left(neighbour_index)
	if left != -1 && is_empty(left):
		swap(neighbour_index, left)
		return
	var right := go_right(neighbour_index)
	if right != -1 && is_empty(right):
		swap(neighbour_index, right)
		return

func swap(neighbour_index: int, empty_index_: int) -> void:
	var neighbour := grid_container.get_child(neighbour_index)
	var empty := grid_container.get_child(empty_index_)
	grid_container.move_child(neighbour, empty_index_)
	grid_container.move_child(empty, neighbour_index)
	empty_index = neighbour_index
	if !initializing && is_solved() && !already_solved:
		already_solved = true
		emit_signal("puzzle_solved")

func go_up(index: int) -> int:
	var new_index := index - COLS
	return new_index if new_index >= 0 else -1

func go_down(index: int) -> int:
	var new_index := index + COLS
	return new_index if new_index < grid_container.get_child_count() else -1

func go_left(index: int) -> int:
	return -1 if index % COLS == 0 else index - 1

func go_right(index: int) -> int:
	return -1 if index % COLS == COLS - 1 else index + 1
