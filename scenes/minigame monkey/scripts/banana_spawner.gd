extends Node2D
class_name BananaSpawner

var monkey_minigame: MonkeyMinigame
var is_started: bool = false

var banana_cooldown: float = 2.5
var banana_timer: float = 2.5
var blue_bomb: PackedScene = preload("res://scenes/minigame monkey/banana_bomb_blue.tscn")
var yellow_bomb: PackedScene = preload("res://scenes/minigame monkey/banana_bomb.tscn")



func start() -> void:
	is_started = true
	banana_timer = monkey_minigame.currently_bananas_cooldown


func _process(delta: float) -> void:
	if !is_started: return
	if banana_timer > 0: 
		banana_timer -= delta
	else:
		spawn_bomb()



func spawn_bomb():
	banana_timer = monkey_minigame.currently_bananas_cooldown
	#print(monkey_minigame.currently_bananas_cooldown)
	
	var target_bomb: PackedScene
	if randf_range(0, 100) > monkey_minigame.currently_blue_chance:
		target_bomb = yellow_bomb
	else:
		target_bomb = blue_bomb
	
	var target_x: float = randf_range(12, 531)
	var target_y: float = randf_range(19, 489)
	
	var bomb_instance = target_bomb.instantiate()
	get_parent().add_child(bomb_instance)
	bomb_instance.global_position = Vector2(target_x, target_y)
