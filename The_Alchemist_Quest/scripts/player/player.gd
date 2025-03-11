extends Area2D
signal hit
export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.animation = "stand"
	$AnimatedSprite.play()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.

	# Capture movement input
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# Normalize movement to avoid diagonal speed increase
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta

		# Play "walk" animation only if it's not already playing
		if $AnimatedSprite.animation != "walk":
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.play()
	else:
		# Play "stand_still" animation only if it's not already playing
		if $AnimatedSprite.animation != "stand":
			$AnimatedSprite.animation = "stand"
			$AnimatedSprite.play()

	# Clamp position to stay within screen bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body, hit):
	hide() # Player disappears after being hit.
	hit.emit()
	$CollisionShape2D.set_deferred("disable", true)
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
