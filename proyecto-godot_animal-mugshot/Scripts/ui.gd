extends Node2D

signal time_ended

@export var max_timer_value : int= 240
var timer_value : int = 0
const left_space : int = 32

func Set_Timer() -> void:
	timer_value = max_timer_value
	$Timer.start()
	$CPUParticles2D.emitting = true

func _on_timer_timeout() -> void:
	timer_value -= 1
	$TextureProgressBar.value = timer_value
	
	if timer_value <= 0:
		$Timer.stop()
		$CPUParticles2D.emitting = false
		emit_signal("time_ended")

func _process(delta: float) -> void:
	var progress_bar = $TextureProgressBar
	var progress_ratio = timer_value / (float(max_timer_value) *1.05)  # Ratio entre 0 y 1
	var start_pos = progress_bar.global_position  # Posición inicial de la barra
	var end_pos = start_pos + Vector2(left_space, progress_bar.size.y * (1 - progress_ratio))

	$CPUParticles2D.global_position = end_pos  # Mover las partículas
