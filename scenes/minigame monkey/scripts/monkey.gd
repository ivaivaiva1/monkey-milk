extends Area2D
class_name Monkey

var monkey_spawner: Monkey_Spawner
@onready var sprite: AnimatedSprite2D = %sprite
var is_collected: bool = false

func _ready() -> void:
	sprite.material = sprite.material.duplicate()


func _on_area_entered(area: Area2D) -> void:
	if is_collected == true: 
		return
	if area.is_in_group("Player"):
		if monkey_spawner == null:
			monkey_spawner = get_parent()
		monkey_spawner.collect_monkey(self)
		is_collected = true
		do_blink_monkey_monkey()



func do_blink_monkey_monkey():
	var tween := create_tween()
	
	for i in 10:
		tween.tween_property(
			sprite.material,
			"shader_parameter/flash_pct",
			1,
			0.08
		)
	
		tween.tween_property(
			sprite.material,
			"shader_parameter/flash_pct",
			0.4,
			0.08
		)
	
	tween.tween_callback(die)


func die():
	monkey_spawner.monkey_minigame.get_milk()
	queue_free()
