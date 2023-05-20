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
	
	$LeftScore.show()
	$RightScore.show()
	
	start.emit()

func _on_quit_button_pressed():
	quit.emit()
	
func _end_game(winner):
	if(winner == -1):
		$LeftWin.show()
	elif(winner == 1):
		$RightWin.show()
		
	await get_tree().create_timer(3.0).timeout
	$LeftWin.hide()
	$RightWin.hide()
	
	$LeftScore.hide()
	$RightScore.hide()
	
	$StartButton.show()
	$QuitButton.show()
