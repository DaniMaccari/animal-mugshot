extends Node2D

var my_position : Vector2
var of_set : Vector2 = Vector2( 0, 0)
var dragging : bool = false

var is_bad : bool = false
var in_jail : bool = false
var front_side : bool = false


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = lerp(position, get_global_mouse_position() - of_set, delta *15)
	else:
		position = my_position
	

func set_grid_position( grid_position : Vector2) -> void:
	my_position = grid_position

func _on_is_dragged_button_down() -> void:
	dragging = true
	of_set = get_global_mouse_position() - global_position

func _on_is_dragged_button_up() -> void:
	if in_jail:
		my_position =  get_parent().get_parent().get_node("Jail").position
	dragging = false

func _on_is_dragged_pressed() -> void:
	front_side = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Jail"):
		in_jail = true
		print("Estoy en la carcer")

func _on_area_2d_area_exited(area: Area2D) -> void:
	in_jail = false
