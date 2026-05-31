extends Node2D

@export var explosion: PackedScene 
@export var shake_force: float

@onready var banana_shadow: Node2D = %BananaShadow
@onready var bananas: CharacterBody2D = %Bananas
@onready var initial_distance: float = abs(bananas.global_position.y - banana_shadow.global_position.y)


func _process(delta: float) -> void:
	update_shadow()
	update_banana_scale()


func _physics_process(delta: float) -> void:
	move_bananas(delta)


func move_bananas(delta: float):
	if bananas.global_position.y > banana_shadow.global_position.y - 12: 
		banana_shadow.scale = Vector2.ONE
		SfxPlayer.play_sfx(SOUNDS_LIST.BANANAEXPLOSION_SFX)
		spawn_explosion()
		queue_free()
	
	bananas.velocity += bananas.get_gravity()/6 * delta
	bananas.move_and_slide()


func spawn_explosion():
	var explosion_instance = explosion.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	ScreenShake.do_screen_shake(shake_force, 0.2)


@onready var initial_shadow_scale: Vector2 = banana_shadow.scale
func update_shadow() -> void:
	var current_distance = abs(
		bananas.global_position.y - banana_shadow.global_position.y
	)
	
	# 0 = distância inicial, 1 = chegou na sombra
	var progress = 1.0 - (current_distance / initial_distance)
	progress = clamp(progress, 0.0, 1.0)
	
	banana_shadow.scale = initial_shadow_scale.lerp(Vector2(0.8, 0.8), progress)


@onready var initial_banana_scale: Vector2 = bananas.scale
func update_banana_scale() -> void:
	var current_distance = abs(
		bananas.global_position.y - banana_shadow.global_position.y
	)
	
	var progress = 1.0 - (current_distance / initial_distance)
	progress = clamp(progress, 0.0, 1.0)
	
	bananas.scale = initial_banana_scale.lerp(Vector2.ONE, progress)
