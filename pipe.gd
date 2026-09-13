extends StaticBody2D

var speed = 250.0
var scored = false


func _process(delta):
	position.x -= speed * delta

	if position.x < -150:
		queue_free()
