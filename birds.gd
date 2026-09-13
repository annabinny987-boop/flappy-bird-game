
extends CharacterBody2D

var gravity = 900.0
var flap_strength = -350.0


func _physics_process(delta):
	# Gravity
	velocity.y += gravity * delta

	# Flap
	if Input.is_action_just_pressed("flap"):
		velocity.y = flap_strength

	# Move bird
	move_and_slide()

	# Game over when bird hits pipe or ground
	if get_slide_collision_count() > 0:
		get_parent().game_over()
