extends Node2D

@export var ball_scene: PackedScene
@export var win_amount = 10
@export var delay = 2
var serveSide

var leftScore = 0
var rightScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Engine.set_physics_ticks_per_second(240)

# Start game connecting function
func _on_hud_start(singleplayer):
	serveSide = randi() % 2
	
	$RightPaddle.singleplayer = singleplayer
	$LeftPaddle.set_process(true)
	$RightPaddle.set_process(true)
	
	leftScore = 0
	rightScore = 0
	$HUD/LeftScore.text = str(leftScore)
	$HUD/RightScore.text = str(rightScore)
	
	if(serveSide == 0):
		serveSide = -1
	
	_startRound()

# Instantiate new ball and hook it into the main scene
func _startRound():
	var ball = ball_scene.instantiate()
	add_child(ball)
	$RightPaddle.ball = ball

	ball.score.connect(_on_ball_score)
	ball.setup(delay, serveSide)

# When main sees that the ball scores, increment the score, check if either player has reached the score limit, and if not spawn another ball
func _on_ball_score(side):
#	if($RightPaddle.singleplayer):
#		$RightPaddle.ball = $RightPaddle
	
	if(side == -1):
		leftScore += 1
		$HUD/LeftScore.text = str(leftScore)
	elif(side == 1):
		rightScore += 1
		$HUD/RightScore.text = str(rightScore)
	
	if(leftScore >= win_amount): 
		_end_game(-1)
	elif(rightScore >= win_amount):
		_end_game(1)
	else:	
		serveSide = side # Set the ball to serve to the player who scored last
		$ScoreSound.play()
		
		_startRound()

func _end_game(winner):
	$LeftPaddle.set_process(false)
	$RightPaddle.set_process(false)
	$HUD._end_game_screen(winner)
	$WinSound.play()

# Quit game button
func _on_hud_quit():
	get_tree().quit()
	


	







