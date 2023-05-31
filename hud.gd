extends CanvasLayer

signal start(singeplayer)
signal quit()

func _on_start_singleplayer_button_pressed():
	start_game(true)

func _on_start_multiplayer_button_pressed():
	start_game(false)

func _on_quit_button_pressed():
	quit.emit()
	
func start_game(singleplayer):
	$StartSingleplayerButton.hide()
	$StartMultiplayerButton.hide()
	$QuitButton.hide()
	
	$LeftScore.show()
	$RightScore.show()
	
	start.emit(singleplayer)
	
func _end_game_screen(winner):
	if(winner == -1):
		$LeftWin.show()
	elif(winner == 1):
		$RightWin.show()
		
	await get_tree().create_timer(3.0).timeout
	$LeftWin.hide()
	$RightWin.hide()
	
	$LeftScore.hide()
	$RightScore.hide()
	
	$StartSingleplayerButton.show()
	$StartMultiplayerButton.show()
	$QuitButton.show()






