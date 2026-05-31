extends Node2D
class_name MonkeyMinigame

@onready var player: CharacterBody2D = %Player
@onready var monkey_spawner: Monkey_Spawner = %MonkeySpawner
@onready var banana_spawner: BananaSpawner = %BananaSpawner
@onready var tutorial: Tutorial = %TutorialPopUp


@onready var game_over_info: RichTextLabel = %GameOverInfo
@onready var global_milk_label: RichTextLabel = %GlobalMilkLabel
@onready var milk_counter: Label = %MilkCounter
@onready var blur_color_rect: ColorRect = %BlurColorRect




var milk: int = 0


func _ready() -> void:
	Engine.time_scale = 1
	if MusicManager.current_playing_music != SOUNDS_LIST.MONKEYMINIGAME_MUSIC["stream"]:
		MusicManager.play_instant(SOUNDS_LIST.MONKEYMINIGAME_MUSIC)
	
	tutorial.monkey_minigame = self
	
	monkey_spawner.monkey_minigame = self
	monkey_spawner.start()
	
	banana_spawner.monkey_minigame = self
	banana_spawner.start()
	
	player.monkey_minigame = self
	player.change_anim()
	
	get_tree().paused = true


func start_game():
	if Dialogic.VAR.get_variable("player_gender") != "":
		Globals.player_gender = Dialogic.VAR.get_variable("player_gender")
	player.global_position = Vector2(270, 230)
	blur_screen(false)
	milk_counter.visible = true


func _process(delta: float) -> void:
	game_countdown(delta)
	increase_bananas_overtime()
	increase_BlueBananas_overtime()
	increase_monkeys_overtime()



func get_milk():
	milk += 1
	milk_counter.text = "Milk: " + str(milk)


@onready var game_over_panel = $UI/GameOverPanel
@onready var done_button: Button = %DoneButton
@onready var not_enough: RichTextLabel = %"not enough"
func game_over():
	SfxPlayer.play_sfx(SOUNDS_LIST.GAMEOVER_SFX)
	Globals.milk += milk
	blur_screen(true)
	milk_counter.visible = false
	game_over_info.text = "You collected " + str(milk) + " liters of milk."
	global_milk_label.text = "Milk:" + str(Globals.milk)
	game_over_panel.visible = true
	if Globals.milk >= 50:
		done_button.visible = true
		not_enough.visible = false
	else:
		done_button.visible = false
		not_enough.visible = true
	#get_tree().paused = true

func _on_try_again_button_button_down() -> void:
	get_tree().reload_current_scene()

func _on_done_button_button_down() -> void:
	Engine.time_scale = 1
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


# conta a quanto tempo o jogo esta rodando pra ir dificultando ele aos poucos
var game_timer: float = 0
var max_timer: float = 100
func game_countdown(delta: float):
	if  game_timer < max_timer:
		game_timer += delta 
	else:
		game_timer = max_timer


# deixa spawn de bananas mais rapido
var currently_bananas_cooldown: float = 3
var initial_banana_cooldown: float = 3
var final_banana_cooldown: float =  0.5
func increase_bananas_overtime() -> void:
	var progress = game_timer / max_timer
	progress = clamp(progress, 0.0, 1.0)
	currently_bananas_cooldown = lerp(initial_banana_cooldown, final_banana_cooldown, progress)


# aumenta a chance de spawnar bananas azuis
var currently_blue_chance: float = 20
var initial_blue_chance: float = 20
var final_blue_chance: float =  50
func increase_BlueBananas_overtime() -> void:
	var progress = game_timer / max_timer
	progress = clamp(progress, 0.0, 1.0)
	currently_blue_chance = lerp(initial_blue_chance, final_blue_chance, progress)


# aumenta a velocidade de spawn dos macacos
var currently_monkey_cooldown: float = 2
var initial_monkey_cooldown: float = 2
var final_monkey_cooldown: float =  0.5
func increase_monkeys_overtime() -> void:
	var progress = game_timer / max_timer
	progress = clamp(progress, 0.0, 1.0)
	currently_monkey_cooldown = lerp(initial_monkey_cooldown, final_monkey_cooldown, progress)
