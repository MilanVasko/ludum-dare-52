extends Panel

onready var dialogues := $Dialogues
onready var next_or_close := $NextOrClose
var current_dialogue: Control = null

func _on_dialogue_start(dialogue_id: String) -> void:
	if dialogue_id == "start":
		show_dialogue(dialogues.get_node("Start"))
	else:
		print("Unknown dialogue ID: ", dialogue_id)

func show_dialogue(which: Control) -> void:
	get_tree().paused = true

	Global.show_just_one(dialogues.get_children(), which)
	current_dialogue = which
	next_or_close.text = which.get_label()
	show()
	next_or_close.grab_focus()

func _on_next_or_close_pressed() -> void:
	if !current_dialogue.show_next():
		hide()
		get_tree().paused = false
	next_or_close.text = current_dialogue.get_label()
