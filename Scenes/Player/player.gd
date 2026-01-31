extends CharacterBody2D

@export var move_speed: float = 100

func _ready() -> void:
	print("Player ready with move_speed: ", move_speed)

func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed

	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.stop()
	elif abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			$AnimatedSprite2D.play("move_right")
		else:
			$AnimatedSprite2D.play("move_left")
	else:
		if velocity.y > 0:
			$AnimatedSprite2D.play("move_down")
		else:
			$AnimatedSprite2D.play("move_up")

	move_and_slide()
