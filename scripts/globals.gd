extends Node

var need_tutorial: bool = true
var milk := 0
var player_gender: String = "female"
var last_dialogue: LastDialogue = LastDialogue.NULL


enum LastDialogue {
	NULL,
	INTRO,
	GOT_MILK,
	CAULDRON,
	FINAL
}

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		print_active_scenes()



func print_active_scenes():
	print("=== CENAS/NÓS ATIVOS ===")
	
	for child in get_tree().root.get_children():
		print(child.name, " | ", child.scene_file_path)
