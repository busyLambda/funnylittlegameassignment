extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var max_charge = 30000

@onready var _animation_player = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var total = 0
var limit = -140
var pt = 0
var health = 100

var is_attacking = false

func _physics_process(delta):
	velocity.y += gravity * delta

	handle_movement()
	handle_jump()
	handle_attacking()

	move_and_slide()

func handle_attacking():
	if is_attacking == false && Input.is_action_pressed("attack"):
		is_attacking = true
		_animation_player.play("attack")
		is_attacking = false

func handle_movement():
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
		_animation_player.play("run")
		_animation_player.flip_h = true  # Invert the sprite when moving left
	elif Input.is_action_pressed("move_right"):
		direction += 1
		_animation_player.play("run")
		_animation_player.flip_h = false  # Do not invert the sprite when moving right
	else:
		_animation_player.play("idle")

	velocity.x = direction * speed

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		pt = Time.get_unix_time_from_system()
	if Input.is_action_just_released("jump") and is_on_floor():
		var jump_boost = (pt - Time.get_unix_time_from_system()) * 100
		if jump_boost < limit:
			jump_boost = limit
		print(jump_boost)
		velocity.y = jump_speed + jump_boost
	if velocity.y <= 0:
		_animation_player.play("jump")
	if velocity.y >= 0 and !is_on_floor():
		_animation_player.play("falling")
