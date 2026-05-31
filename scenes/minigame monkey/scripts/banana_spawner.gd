extends Node2D
class_name BananaSpawner


var spawn_cooldown: float = 1
@onready var timer: float = randf_range(spawn_cooldown * 0.5, spawn_cooldown * 1.5)
var blue_bomb: PackedScene = preload("res://scenes/minigame monkey/banana_bomb_blue.tscn")
var yellow_bomb: PackedScene = preload("res://scenes/minigame monkey/banana_bomb.tscn")


func _ready() -> void:
	randomize()


func _process(delta: float) -> void:
	if timer > 0: 
		timer -= delta
	else:
		timer = randf_range(spawn_cooldown * 0.5, spawn_cooldown * 1.5)
		spawn_bomb()



func spawn_bomb():
	var target_bomb: PackedScene
	if randf_range(0, 100) > 20:
		target_bomb = yellow_bomb
	else:
		target_bomb = blue_bomb
	
	var target_x: float = randf_range(12, 531)
	var target_y: float = randf_range(19, 489)
	
	var bomb_instance = target_bomb.instantiate()
	get_parent().add_child(bomb_instance)
	bomb_instance.global_position = Vector2(target_x, target_y)
