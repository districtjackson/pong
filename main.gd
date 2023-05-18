extends Node2D

@export var ball_scene: PackedScene

@export var delay = 2
var serveSide

var player1Score = 0
var player2Score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	serveSide = randi() % 2

	
	_startRound()

func _startRound():
	var ball = ball_scene.instantiate()
	ball.setup(delay, serveSide)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# When main sees that the ball scores, increment the score, check if either player has reached the score limit, and if not spawn another ball
func _on_ball_score(side):
	# Update points on the UI
	
	if(player1Score >= 10): 
		pass # UI element pops up saying who wins, then game goes back to main menu
	elif(player2Score >= 10):
		pass
	else:	
		serveSide = side # Set the ball to serve to the player who scored last
		_startRound()
