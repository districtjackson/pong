extends RigidBody2D

signal score(side)

@export var paddle_scene: PackedScene
@export var speed = 300
@export var acceleration = 2

var delayLength = 2
var serveSide = -1 # -1 == left, 1 == right

# Called when the node enters the scene tree for the first time.
func setup(delay = 2, side = -1):
	delayLength = delay
	serveSide = side

	$StartTimer.start(delayLength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If ball goes out either side, tells main that there was a goal and which side, then deletes itself
	if(position.x <= 0): 
		score.emit(1)
		queue_free()
	elif(position.x >= 1920):
		score.emit(-1)
		queue_free()

# When game delay timer stops, ball starts moving
func _on_timer_timeout():	
	apply_central_impulse(Vector2(speed * serveSide, speed * serveSide)) # need to revise how it serves so it has a random y value, probably should normalize it

# When ball stops touching a paddle, apply impulse in its new direction to give it a boost and make the game more competitive further into the round
func _on_body_exited(body):

	if(body.name == "RightPaddle" or body.name == "LeftPaddle"):
		apply_central_impulse(linear_velocity / 2)

		
