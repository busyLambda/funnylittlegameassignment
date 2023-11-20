extends CharacterBody2D

@onready var _animation_player = $AnimatedSprite2D

var health = 100;

func _physics_process(delta):
	if is_on_floor:
		_animation_player.play("idle")
