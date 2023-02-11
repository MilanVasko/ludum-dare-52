extends Control

func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle()

func _on_unpause_pressed() -> void:
	toggle()

func toggle() -> void:
	if !get_tree().paused:
		get_tree().paused = true
		refresh()
		return
	if visible:
		get_tree().paused = !get_tree().paused
		refresh()

func refresh() -> void:
	visible = get_tree().paused
	if visible:
		$Panel/Unpause.grab_focus()
