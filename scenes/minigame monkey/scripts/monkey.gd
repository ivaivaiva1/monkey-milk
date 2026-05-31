extends Area2D
class_name Monkey

var monkey_spawner: Monkey_Spawner
@onready var sprite: AnimatedSprite2D = %sprite
var is_collected: bool = false
var is_dead: bool = false

func _ready() -> void:
	sprite.material = sprite.material.duplicate()
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE, 0.8)


func _on_area_entered(area: Area2D) -> void:
	if is_collected == true: 
		return
	if area.is_in_group("Player"):
		if monkey_spawner == null:
			monkey_spawner = get_parent()
		SfxPlayer.play_sfx(SOUNDS_LIST.PICKMONKEY_SFX)
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
	if is_dead: return
	is_dead = true
	monkey_spawner.collect_monkey(self)
	monkey_spawner.monkey_minigame.get_milk()
	SfxPlayer.play_sfx(SOUNDS_LIST.GET_MILK)
	queue_free()
