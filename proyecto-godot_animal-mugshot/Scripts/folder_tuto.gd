extends Sprite2D

var dragging : bool = false
var of_set = Vector2( 0, 0)

func _process(delta: float) -> void:
	if dragging:
		position = lerp(position, get_global_mouse_position() - of_set, delta *10)
	pass

func _on_button_button_down() -> void:
	$PaperTouch.play(0.25)
	$Shadow.show()
	
	get_viewport().set_input_as_handled()
	dragging = true
	of_set = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	$Shadow.hide()
	
	dragging = false
	of_set = Vector2( 0, 0)

func Disable() -> void:
	$Button.disabled = true
