extends Control

var current_index := 0

func _ready() -> void:
	if get_child_count() > 0:
		show_index(0)

func get_label() -> String:
	return "Next" if get_child_count() > 0 && current_index != get_child_count() - 1 else "Close"

func show_next() -> bool:
	if current_index < get_child_count() - 1:
		show_index(current_index + 1)
		return true
	return false

func show_index(index: int) -> void:
	current_index = index
	Global.show_just_one(get_children(), get_child(index))
