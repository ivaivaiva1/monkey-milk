extends CharacterBody2D

var monkey_minigame: MonkeyMinigame
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 2.8
const ACCELERATION = 3.7
const FRICTION = 60
var direction: Vector2

func _process(delta: float) -> void:
	print(Globals.player_gender)
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
		else:
			anim.play("walk_boy")
	else:
		if Globals.player_gender == "female":
			anim.play("idle_girl")
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
		monkey_minigame.game_over()
