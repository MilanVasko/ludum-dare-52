extends Panel

onready var dialogues := $Dialogues
onready var next_or_close := $NextOrClose
onready var label := $NextOrClose/Label
var current_dialogue: Control = null

func _ready() -> void:
	hide()
	label.add_color_override("font_color", Color(0, 0, 0))

func _on_dialogue_start(dialogue_id: String) -> void:
	if dialogue_id == "level1/start":
		show_dialogue(dialogues.get_node("Level1Start"))
	elif dialogue_id == "level1/blood_area":
		show_dialogue(dialogues.get_node("Level1BloodArea"))
	elif dialogue_id == "level1/lab_area":
		show_dialogue(dialogues.get_node("Level1LabArea"))
	elif dialogue_id == "level1/mr_wheat_area":
		show_dialogue(dialogues.get_node("Level1MrWheatArea"))
	elif dialogue_id == "level1/elevator_switch_disabled_init":
		show_dialogue(dialogues.get_node("Level1ElevatorSwitchDisabledInit"))
	elif dialogue_id == "level1/keypad_intro":
		show_dialogue(dialogues.get_node("Level1KeypadIntro"))
	elif dialogue_id == "level1/players_office_intro":
		show_dialogue(dialogues.get_node("Level1PlayersOfficeIntro"))
	elif dialogue_id == "level1/burner_intro":
		show_dialogue(dialogues.get_node("Level1BurnerIntro"))
	elif dialogue_id == "ending/greg":
		show_dialogue(dialogues.get_node("EndingGreg"))
	else:
		print("Unknown dialogue ID: ", dialogue_id)

func show_dialogue(which: Control) -> void:
	get_tree().paused = true

	Global.show_just_one(dialogues.get_children(), which)
	current_dialogue = which
	label.text = (which.get_label())
	show()
	next_or_close.grab_focus()

func _on_next_or_close_pressed() -> void:
	if !current_dialogue.show_next():
		hide()
		get_tree().paused = false
		if current_dialogue.has_method("_on_dialogue_end"):
			current_dialogue._on_dialogue_end()
	label.text = current_dialogue.get_label()
