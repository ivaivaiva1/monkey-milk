extends Node2D

func _ready():
	var timeline = Dialogic.start("Intro")

	add_child(timeline)

	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	get_tree().change_scene_to_file("res://scenes/minigame monkey/monkeys_minigame.tscn")
