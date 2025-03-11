extends KinematicBody2D  # Changed from Node2D to KinematicBody2D

export var speed = 400
var velocity = Vector2.ZERO  # Movement vector

func _ready():
	$AnimatedSprite.animation = "stand"
	$AnimatedSprite.play()

func _physics_process(delta):  # Use _physics_process for physics updates
	velocity = Vector2.ZERO  # Reset velocity each frame

	# Capture movement input
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# Normalize movement to prevent diagonal speed boost
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

		if $AnimatedSprite.animation != "walk":
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.play()
	else:
		if $AnimatedSprite.animation != "stand":
			$AnimatedSprite.animation = "stand"
			$AnimatedSprite.play()

	# Move player with collision handling
	velocity = move_and_slide(velocity)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Collision detection function
func _on_Player_body_entered(body):
	print("Hit the wall: ", body.name)
