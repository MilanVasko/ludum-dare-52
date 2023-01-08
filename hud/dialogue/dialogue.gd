extends Panel

onready var dialogues := $Dialogues
onready var next_or_close := $NextOrClose
var current_dialogue: Control = null

func _ready() -> void:
	hide()

func _on_dialogue_start(dialogue_id: String) -> void:
	if dialogue_id == "level1/start":
		show_dialogue(dialogues.get_node("Level1Start"))
	elif dialogue_id == "level1/blood_area":
		show_dialogue(dialogues.get_node("Level1BloodArea"))
	elif dialogue_id == "level1/lab_area":
		show_dialogue(dialogues.get_node("Level1LabArea"))
	elif dialogue_id == "level1/mr_wheat_area":
		show_dialogue(dialogues.get_node("Level1MrWheatArea"))
	elif dialogue_id == "ending/greg":
		show_dialogue(dialogues.get_node("EndingGreg"))
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
		if current_dialogue.has_method("_on_dialogue_end"):
			current_dialogue._on_dialogue_end()
	next_or_close.text = current_dialogue.get_label()
