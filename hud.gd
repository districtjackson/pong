extends CanvasLayer

signal start()
signal quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	start.emit()

func _on_quit_button_pressed():
	quit.emit()
	
func _end_game(winner):
	if(winner == -1):
		$HUD/LeftWin.show()
	elif(winner == 1):
		$HUD/RightWin.show()
		
	# show proper winner label
	# one shot timer
	# winner label disappears
	# reset scores
	# bring up buttons
