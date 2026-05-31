extends CharacterBody2D
class_name Banana

var direction: Vector2

const SPEED = 300.0
const ROTATION_SPEED = 12 # radianos por segundo

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * SPEED
	move_and_slide()
	
	rotation += ROTATION_SPEED * delta
