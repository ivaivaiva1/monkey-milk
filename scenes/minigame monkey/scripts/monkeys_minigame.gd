extends Node2D
class_name MonkeyMinigame

@onready var player: CharacterBody2D = %Player
@onready var monkey_spawner: Monkey_Spawner = %MonkeySpawner
@onready var tutorial: Tutorial = %TutorialPopUp


@onready var game_over_info: RichTextLabel = %GameOverInfo
@onready var global_milk_label: RichTextLabel = %GlobalMilkLabel
@onready var milk_counter: Label = %MilkCounter
@onready var blur_color_rect: ColorRect = %BlurColorRect




var milk: int = 0


func _ready() -> void:
	tutorial.monkey_minigame = self
	monkey_spawner.monkey_minigame = self
	player.monkey_minigame = self
	player.change_anim()
	get_tree().paused = true


func start_game():
	if Dialogic.VAR.get_variable("player_gender") != "":
		Globals.player_gender = Dialogic.VAR.get_variable("player_gender")
	player.global_position = Vector2(270, 250)
	blur_screen(false)
	milk_counter.visible = true


func get_milk():
	milk += 1
	milk_counter.text = "Milk: " + str(milk)

func victory():
	get_tree().change_scene_to_file(
		"res://scenes/minigame crafting/crafting_minigame.tscn"
	)

@onready var game_over_panel = $UI/GameOverPanel

func game_over():
	Globals.milk += milk
	print(Globals.milk)
	blur_screen(true)
	milk_counter.visible = false
	game_over_info.text = "You collected " + str(milk) + " liters of milk."
	global_milk_label.text = "Milk:" + str(Globals.milk)
	game_over_panel.visible = true
	get_tree().paused = true

func _on_try_again_button_button_down() -> void:
	get_tree().reload_current_scene()

func _on_done_button_button_down() -> void:
	get_tree().change_scene_to_file("res://dialogues/dialogue_scene.tscn")


func blur_screen(condition: bool):
	var target_strenght: float
	var tween_time: float
	if condition == true:
		target_strenght = 3.0
		tween_time = 0.4
	else:
		target_strenght = 0.0
		tween_time = 0.2
	
	var blur_material: ShaderMaterial = blur_color_rect.material
	var tween = blur_color_rect.create_tween()
	tween.tween_property(blur_material, "shader_parameter/strength", target_strenght, tween_time)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
