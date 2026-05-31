extends Node2D
class_name Monkey_Spawner

var monkey_minigame: MonkeyMinigame

var monkey_scene: PackedScene = preload("res://scenes/minigame monkey/monkey.tscn")
var monkeys: Array[Monkey] = []
var monkey_cooldown: float = 3
@onready var monkey_timer: float = randf_range(monkey_cooldown * 0.5, monkey_cooldown * 1.5)


func _ready() -> void:
	randomize()


func _process(delta: float) -> void:
	if monkey_timer > 0:
		monkey_timer -= delta
	else:
		if monkeys.size() == 5:
			monkey_timer = randf_range(monkey_cooldown * 0.5, monkey_cooldown * 1.5)
			return
		monkey_timer = randf_range(monkey_cooldown * 0.5, monkey_cooldown * 1.5)
		spawn_monkey()



func spawn_monkey():
	var monkey_instance = monkey_scene.instantiate()
	monkeys.append(monkey_instance)
	var target_x: float = randf_range(49, 498)
	var target_y: float = randf_range(41, 462)
	self.add_child(monkey_instance)
	monkey_instance.global_position = Vector2(target_x, target_y)
	monkey_instance.monkey_spawner = self


func collect_monkey(monkey: Monkey):
	monkeys.erase(monkey)
