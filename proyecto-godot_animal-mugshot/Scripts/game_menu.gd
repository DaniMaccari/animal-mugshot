extends Node2D

var first_time : bool = true

func Show_Menu() -> void:
	
	if first_time:
		$Start.show()
		$Tuto_Folder.show()
		
	else:
		$End.show()
	
	$StartGameButton.disabled = false
	
func Hide_Menu() -> void:
	$StartGameButton.disabled = true
	
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	$Tuto_Folder.Disable()
	
	if first_time:
		tween.tween_property($Start, "position:y", $Start.position.y - 60, 0.3)
		tween.tween_property($Start, "modulate:a", 0.0, 0.3)
		tween.tween_property($Tuto_Folder, "modulate:a", 0.0, 0.2)
		first_time = false
	
	else:
		tween.tween_property($End, "position:y", $End.position.y - 60, 0.3)
		tween.tween_property($End, "modulate:a", 0.0, 0.3)
	
	

func _on_start_game_button_mouse_entered() -> void:
	if Global.is_playing == false:
		if first_time:
			$Start/Start_Shadow.show()
		else:
			$End/Start_Shadow.show()

func _on_start_game_button_mouse_exited() -> void:
	if Global.is_playing == false:
		$Start/Start_Shadow.hide()
		$End/Start_Shadow.hide()
