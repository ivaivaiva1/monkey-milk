extends CharacterBody2D

var monkey_minigame: MonkeyMinigame
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var is_started: bool = false

const SPEED = 2.8
const ACCELERATION = 3.7
const FRICTION = 60
var direction: Vector2

@export var hearts: Array[Sprite2D] = []
var max_life: int = 3
var current_life: int = 3 
var hited_bananas: Array[int] = []


func _ready() -> void:
	anim.material = anim.material.duplicate()


func start():
	is_started = true


func _process(delta: float) -> void:
	if frame_freeze_cooldown > 0:
		frame_freeze_cooldown -= delta
	player_warp()


func _physics_process(delta: float) -> void:
	player_movement(delta)
	change_anim()
	sprite_flip()
	move_and_slide()


func player_movement(delta: float):
	direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if direction.length() > 0.1:
		var target_velocity = direction.normalized() * SPEED * 100
		
		velocity.x = move_toward(
			velocity.x,
			target_velocity.x,
			(ACCELERATION * 100 * delta) / FRICTION * 100
		)
		
		velocity.y = move_toward(
			velocity.y,
			target_velocity.y * 0.8,
			(ACCELERATION * 100 * delta) / FRICTION * 100
		)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * 15 * delta)
		velocity.y = move_toward(velocity.y, 0, FRICTION * 15 * delta)


func change_anim():
	if direction.length() > 0.1:
		if Globals.player_gender == "female":
			anim.play("walk_girl")
		elif Globals.player_gender == "nonbinary":
			anim.play("walk_nonbinary")
		else:
			anim.play("walk_boy")
	else:
		if Globals.player_gender == "female":
			anim.play("idle_girl")
		elif Globals.player_gender == "nonbinary":
			anim.play("idle_nonbinary")
		else:
			anim.play("idle_boy")



func sprite_flip():
	if direction.x > 0:
		anim.flip_h = false
	elif direction.x < 0:
		anim.flip_h = true


func player_warp():
	# warp x
	if global_position.x > 546.0:
		global_position.x = -5
	elif global_position.x < -6.0:
		global_position.x = 545
	
	# warp y
	if global_position.y < -20.0:
		global_position.y = 499
	elif global_position.y > 500.0:
		global_position.y = -19


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bananas"):
		var banana: Banana = area.get_parent() as Banana
		
		if banana.id in hited_bananas:
			return
		
		hited_bananas.append(banana.id)
		get_hited()



func get_hited():
	SfxPlayer.play_sfx(SOUNDS_LIST.GAMEOVER_SFX)
	SfxPlayer.play_sfx(SOUNDS_LIST.DAMAGEMALE_SFX)
	frameFreeze()
	flash_red()
	current_life -= 1
	if current_life <= 0:
		monkey_minigame.game_over()
		queue_free()
	update_hearts()


func update_hearts():
	for i in range(hearts.size()):
		hearts[i].visible = i < current_life


var flash_red_tween: Tween
func flash_red():
	if flash_red_tween:
		flash_red_tween.kill()
	
	anim.material.set_shader_parameter("flash_pct", 0.0)
	
	flash_red_tween = create_tween()
	flash_red_tween.set_trans(Tween.TRANS_BACK)
	flash_red_tween.set_ease(Tween.EASE_OUT)
	
	flash_red_tween.tween_property(
		anim.material,
		"shader_parameter/flash_pct",
		0.55,
		0.03
	)
	
	flash_red_tween.tween_property(
		anim.material,
		"shader_parameter/flash_pct",
		0.0,
		0.3
	)


var frame_freeze_cooldown: float = 0
var frame_freeze_time: float = 0.5
func frameFreeze():
	if frame_freeze_cooldown > 0: return
	Engine.time_scale = 0.1
	await get_tree().create_timer(frame_freeze_time * 0.1).timeout 
	Engine.time_scale = 1
	frame_freeze_cooldown = frame_freeze_time
