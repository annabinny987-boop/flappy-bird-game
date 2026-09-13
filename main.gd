extends Node2D

var pipe_scene = preload("res://pipe.tscn")

var spawn_timer = 0.0
var spawn_interval = 2.0

var score = 0
var score_label
var is_game_over = false

var rng = RandomNumberGenerator.new()

@onready var game_over_label = $game_over_label
@onready var restart_button = $restart_button
@onready var bird = $Birds


func _ready():
	rng.randomize()

	# Score
	score_label = Label.new()
	score_label.text = "Score: 0"
	score_label.position = Vector2(30, 30)
	score_label.add_theme_font_size_override("font_size", 32)
	add_child(score_label)

	# Hide game over screen
	game_over_label.visible = false
	restart_button.visible = false

	# Connect restart button
	restart_button.pressed.connect(restart_game)

	# Start with one pipe
	spawn_pipe()


func _process(delta):
	# Don't continue the game after Game Over
	if is_game_over:
		return

	# Spawn pipes
	spawn_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_pipe()

	# Score
	for pipe in get_children():
		if pipe.is_in_group("pipes") and not pipe.scored:
			if pipe.position.x < 300:
				pipe.scored = true
				score += 1
				score_label.text = "Score: " + str(score)


func spawn_pipe():
	var pipe = pipe_scene.instantiate()

	pipe.position = Vector2(1100, rng.randi_range(180, 420))

	pipe.add_to_group("pipes")

	add_child(pipe)


func game_over():
	if is_game_over:
		return

	is_game_over = true

	# Show Game Over
	game_over_label.visible = true
	restart_button.visible = true

	# Stop the bird
	bird.set_physics_process(false)


func restart_game():
	get_tree().reload_current_scene()
