extends Node2D

@onready var marker: ColorRect = $Marker
@onready var success_zone: ColorRect = $SuccessZone
@onready var result_label: Label = $ResultLabel
@onready var bar: ColorRect = $Bar
@onready var progress_label: Label = $ProgressLabel


var speed = 300
var direction = 1

var successes = 0
const REQUIRED_SUCCESSES = 10

func _ready():
	randomize()
	update_progress()
	randomize_zone()
	
	var min_x = bar.position.x
	var max_x = bar.position.x + bar.size.x - success_zone.size.x
	
	success_zone.position.x = randf_range(min_x, max_x)

func _process(delta):
	marker.position.x += speed * direction * delta
	
	var left = bar.position.x
	var right = bar.position.x + bar.size.x
	
	if marker.position.x >= right:
		direction = -1
	
	if marker.position.x <= left:
		direction = 1

func update_progress():
	var text = ""
	
	for i in range(REQUIRED_SUCCESSES):
		if i < successes:
			text += "[X]"
		else:
			text += "[  ]"
	
	progress_label.text = text

func randomize_zone():
	var min_x = bar.position.x
	var max_x = bar.position.x + bar.size.x - success_zone.size.x
	
	success_zone.position.x = randf_range(min_x, max_x)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		check_result()


func check_result():
	var marker_x = marker.global_position.x
	
	var left = success_zone.global_position.x
	var right = left + success_zone.size.x
	
	if marker_x >= left and marker_x <= right:
		successes += 1
		update_progress()
		if successes >= REQUIRED_SUCCESSES:
			ritual_complete()
		else:
			randomize_zone()
	else:
		randomize_zone()
		ritual_failed()


func ritual_complete():
	result_label.text = "RITUAL COMPLETE!"
	
	await get_tree().create_timer(1.5).timeout
	
	get_tree().change_scene_to_file(
		"res://scenes/ZombieDialogue.tscn"
	)


func ritual_failed():
	#	get_tree().change_scene_to_file("")
	print("fail")
