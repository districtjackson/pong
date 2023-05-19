extends RigidBody2D

signal score(side)

@export var paddle_scene: PackedScene
@export var speed = 300

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
	if(position.x <= 0): # This is scoring for some reason
		score.emit(1)
		queue_free()
	elif(position.x >= 1152):
		score.emit(-1)
		queue_free()

# When game delay timer stops, ball starts moving
func _on_timer_timeout():	
	apply_central_impulse(Vector2(speed * serveSide, speed * serveSide))
	
	## Impart force, maybe have to use set_physics_process
	print("Force Applied")

# When ball stops touching a paddle, apply impulse in its new direction
func _on_body_exited(body):
	print(linear_velocity)
	
	if(body.name == "RightPaddle" or body.name == "LeftPaddle"):
		apply_central_impulse(linear_velocity / 2)
		print("Force Applied")
		
