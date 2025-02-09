extends Control

var max_timer_value = 180
var timer_value : int = 0

func Set_Timer() -> void:
	timer_value = max_timer_value
	$Timer.start()

func _on_timer_timeout() -> void:
	timer_value -= 1
	$TextureProgressBar.value = timer_value
	pass # Replace with function body.
