extends Node2D


@onready var intro: DefaultDialogue = %intro
@onready var got_milk: DefaultDialogue = %got_milk


func _ready() -> void:
	if get_tree().paused: get_tree().paused = false
	
	match Globals.last_dialogue:
		Globals.LastDialogue.NULL:
			Globals.last_dialogue = Globals.LastDialogue.INTRO
			intro.start()
			pass
		Globals.LastDialogue.INTRO:
			Globals.last_dialogue = Globals.LastDialogue.GOT_MILK
			got_milk.start()
			pass
		Globals.LastDialogue.CAULDRON:
			#Globals.last_dialogue = Globals.LastDialogue.
			# chama default dialogue 5
			pass
		Globals.LastDialogue.FINAL:
			#Globals.last_dialogue = Globals.LastDialogue.
			# chama default dialogue 5
			pass
		_:
			print("Unkwown Last Dialogue")
