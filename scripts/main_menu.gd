extends Control


func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://dialogues/dialogue_scene.tscn")


func _on_quit_button_button_down() -> void:
	get_tree().quit()
