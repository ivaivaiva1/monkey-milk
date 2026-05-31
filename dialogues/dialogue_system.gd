extends Node2D

@onready var got_milk: DefaultDialogue = %got_milk

func _ready() -> void:
	match Globals.last_dialogue:
		Globals.last_dialogue.NULL:
			#intro.start()
		Globals.LastDialogue.INTRO:
			# chama default dialogue got_milk
			pass
		Globals.LastDialogue.EPICO:
			# chama default dialogue 5
			pass
		Globals.LastDialogue.GRIMORIO:
			# chama default dialogue 5
			pass
		_:
			print("Unkwown Last Dialogue")
