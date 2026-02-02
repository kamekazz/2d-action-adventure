extends CharacterBody2D
class_name Player

@export var move_speed: float = 100
@export var push_strength: float = 25

func _ready() -> void:
	position = SceneManaager.player_spawn_position

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
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var collider_node = collision.get_collider()
		
		if collider_node is RigidBody2D:
			var collision_normal: Vector2 = collision.get_normal()
			collision_normal = collision_normal * push_strength
			collider_node.apply_central_force(-collision_normal)
	
