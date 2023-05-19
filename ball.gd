extends Node2D

signal score(side)

var delayLength = 2
var serveSide = 0

# Called when the node enters the scene tree for the first time.
func setup(delay = 2, side = 0):
	delayLength = delay
	serveSide = side

	$StartTimer.start(delayLength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# If ball goes out either side, tells main that there was a goal and which side, then deletes itself
	if(position.x <= 0): # This is scoring for some reason
		score.emit(1)
		queue_free()
	elif(position.x >= 1920):
		score.emit(0)
		queue_free()

func _on_timer_timeout():
	## Impart force, maybe have to use set_physics_process
	print("Timed Out")
