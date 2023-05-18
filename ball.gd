extends Node2D

signal score(side)

var delayLength = 2
var serveSide = 0

# Called when the node enters the scene tree for the first time.
func setup(delay = 2, side = 0):
	delayLength = delay
	serveSide = side

	$Start.start(delayLength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# If ball goes out either side, tell main that there was a goal and which side, then delete itself
	if(position.x >= 0):
		score.emit(1)
		queue_free()
	elif(position.x <= 1920):
		score.emit(0)
		queue_free()


func _on_timer_timeout():
	## Impart force