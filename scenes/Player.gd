extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var max_charge = 30000
var acceleration = 10.0
var deceleration = 5.0

@onready var _animation_player = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
var total = 0
var health = 100
var jumps_left = 2
var double_jump_enabled = true

var is_attacking = false

func _physics_process(delta):
	velocity.y += gravity * delta

	handle_movement(delta)
	handle_jump()
	handle_attacking()

	move_and_slide()

func handle_attacking():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		_animation_player.play("attack")	
		
func handle_movement(delta):
	var direction = 0.0
	if Input.is_action_pressed("move_left"):
		direction -= 1.0
		if !is_attacking:
			_animation_player.play("run")
		_animation_player.flip_h = true  # Invert the sprite when moving left
	elif Input.is_action_pressed("move_right"):
		direction += 1.0
		if !is_attacking:
			_animation_player.play("run")
		_animation_player.flip_h = false  # Do not invert the sprite when moving right
	else:
		if !is_attacking:
			_animation_player.play("idle")

	if direction != 0.0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
	
func handle_jump():
	if is_on_floor():
		jumps_left = 2
		
	if Input.is_action_just_pressed("jump") and jumps_left != 0:
		jumps_left -= 1
		
		velocity.y = jump_speed
		
	if velocity.y <= 0 and !is_attacking:
		_animation_player.play("jump")
	if velocity.y >= 0 and !is_on_floor() and !is_attacking:
		_animation_player.play("jump")
	
func _on_animated_sprite_2d_animation_finished():
	if _animation_player.animation == "attack":
		is_attacking = false
