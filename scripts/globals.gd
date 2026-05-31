extends Node

var need_tutorial: bool = true
var milk := 0
var player_gender: String = "nonbinary"
var last_dialogue: LastDialogue = LastDialogue.NULL


enum LastDialogue {
	NULL,
	INTRO,
	GOT_MILK,
	CAULDRON,
	FINAL
}
