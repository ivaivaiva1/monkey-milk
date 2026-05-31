extends Node2D
class_name DefaultDialogue

@export var dialogue_name: String
@export var next_scene: String


func start():
	var timeline = Dialogic.start(dialogue_name)
	add_child(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	get_tree().change_scene_to_file(next_scene)
