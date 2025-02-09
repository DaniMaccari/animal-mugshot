extends Node2D

var max_timer_value : int= 180
var timer_value : int = 0
const left_space : int = 32

func Set_Timer() -> void:
	timer_value = max_timer_value
	$Timer.start()

func _on_timer_timeout() -> void:
	timer_value -= 1
	$TextureProgressBar.value = timer_value

func _process(delta: float) -> void:
	var progress_bar = $TextureProgressBar
	var progress_ratio = timer_value / (float(max_timer_value) *1.05)  # Ratio entre 0 y 1
	var start_pos = progress_bar.global_position  # Posición inicial de la barra
	var end_pos = start_pos + Vector2(left_space, progress_bar.size.y * (1 - progress_ratio))

	$CPUParticles2D.global_position = end_pos  # Mover las partículas
