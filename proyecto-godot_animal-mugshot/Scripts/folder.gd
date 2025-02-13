extends Sprite2D

var dragging : bool = false
var of_set = Vector2( 0, 0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if dragging:
		position = lerp(position, get_global_mouse_position() - of_set, delta *10)
	pass

func clean_folder() -> void:
	$Add.hide()
	for i : int in range($Objects_Front/Head.get_child_count()):
		$Objects_Front/Head.get_child(i).hide()
	for i : int in range($Objects_Front/Body.get_child_count()):
		$Objects_Front/Body.get_child(i).hide()
	for i : int in range($Objects_Back/Body.get_child_count()):
		$Objects_Back/Body.get_child(i).hide()
	for i : int in range($Objects_Xray/Body.get_child_count()):
		$Objects_Xray/Body.get_child(i).hide()
	for i : int in range($Objects_yes_no.get_child_count()):
		$Objects_yes_no.get_child(i).hide()

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
