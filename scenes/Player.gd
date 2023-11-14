extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var max_charge = 30000

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var total = 0
var pt = 0

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# This aint exactly the best since it don't workey so find a way to mesure the time :3
		pt = Time.get_unix_time_from_system()
	if Input.is_action_just_released("jump") and is_on_floor():
		var jump_boost = (pt - Time.get_unix_time_from_system()) * 50
		print(jump_boost)
		velocity.y = jump_speed + jump_boost

	# Get the input direction.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	move_and_slide()
