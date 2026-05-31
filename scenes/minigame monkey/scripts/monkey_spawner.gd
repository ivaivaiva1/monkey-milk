extends Node2D
class_name Monkey_Spawner

var monkey_minigame: MonkeyMinigame
var is_started: bool = false

var monkey_scene: PackedScene = preload("res://scenes/minigame monkey/monkey.tscn")
var monkeys: Array[Monkey] = []
var monkey_cooldown: float = 2
var monkey_timer: float


func start() -> void:
	is_started = true
	monkey_timer = monkey_cooldown


func _process(delta: float) -> void:
	if !is_started: return
	if monkey_timer > 0:
		monkey_timer -= delta
	else:
		if monkeys.size() == 5:
			monkey_timer = monkey_minigame.currently_monkey_cooldown
			return
		spawn_monkey()



func spawn_monkey():
	monkey_timer = monkey_minigame.currently_monkey_cooldown
	var monkey_instance = monkey_scene.instantiate()
	monkeys.append(monkey_instance)
	self.add_child(monkey_instance)
	var target_x: float = randf_range(49, 498)
	var target_y: float = randf_range(41, 462)
	monkey_instance.global_position = Vector2(target_x, target_y)
	monkey_instance.monkey_spawner = self


func collect_monkey(monkey: Monkey):
	monkeys.erase(monkey)
