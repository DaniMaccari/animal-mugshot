extends Node2D


const prob_front_empty : int= 1
const prob_back_empty : int = 2
const prob_xray_empty : int = 4
const original_z_index: int = -1

var body_selected : int
var my_position : Vector2
var of_set : Vector2 = Vector2( 0, 0)
var dragging : bool = false

var is_target : bool = false
var in_jail : bool = false
var droped_in_jail : bool = false
var front_side : bool = false


func _ready() -> void:
	$Body_Back.hide()
	$Body_Xray.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = lerp(position, get_global_mouse_position() - of_set, delta *18)
	else:
		if is_target and in_jail:
			self.get_parent().Entered_Jail()
		if position.is_equal_approx(my_position):
			position = my_position
		else:
			position = lerp(position, my_position, delta *20)
		

func set_grid_position( grid_position : Vector2) -> void:
	my_position = grid_position

func set_target():
	is_target = true

func Dress_Character():
	
	# parte delantera
	for i : int in range($Body_Front.get_child_count()):
		var new_item = randi_range(-prob_front_empty, $Body_Front.get_child(i).get_child_count() -1)
		if i == Global.BODY_INDEX:
			if new_item < 0:
				new_item = 0
			body_selected = new_item
			$Body_Front.get_child(i).get_child(new_item).show()
		
		elif new_item < 0:
			pass
		
		else:
			$Body_Front.get_child(i).get_child(new_item).show()
	
	# parte trasera
	for i : int in range($Body_Back.get_child_count()):
		var new_item = randi_range(-prob_back_empty, $Body_Back.get_child(i).get_child_count() -1)
		if i == Global.BODY_INDEX:
			$Body_Back.get_child(i).get_child(body_selected).show()
		
		elif new_item < 0:
			pass
		
		else:
			$Body_Back.get_child(i).get_child(new_item).show()
	
	# parte X-ray
	for i : int in range($Body_Xray.get_child_count()):
		var new_item = randi_range(-prob_xray_empty, $Body_Xray.get_child(i).get_child_count() -1)
		if i == Global.BODY_INDEX:
			$Body_Xray.get_child(i).get_child(body_selected).show()
		
		elif new_item < 0:
			pass
		
		else:
			$Body_Xray.get_child(i).get_child(new_item).show()

	# --- edit target character ------
	if is_target:
		for i : int in range(Global.modified_items.size()): # [parte del cuerpo, item, si/no lo tiene]
			if  i == 0: # Body_Front
				
				if Global.modified_items[i][2] == true: # se tiene que enseñar
					
					for j : int in range($Body_Front.get_child(Global.modified_items[i][0]).get_child_count()):
						$Body_Front.get_child(Global.modified_items[i][0]).get_child(j).hide()
						
					$Body_Front.get_child(Global.modified_items[i][0]).get_child(Global.modified_items[i][1]).show()
				
				else:
					$Body_Front.get_child(Global.modified_items[i][0]).get_child(Global.modified_items[i][1]).hide()
			
			elif i == 1: # Body_Back
				if Global.modified_items[i][2] == true:
					for j : int in range($Body_Back.get_child(1).get_child_count()):
						$Body_Back.get_child(1).get_child(j).hide()
					
					$Body_Back.get_child(1).get_child(Global.modified_items[i][1]).show()
				else:
					$Body_Back.get_child(1).get_child(Global.modified_items[i][1]).hide()
			
			elif i == 2: # Body_Xray
				if Global.modified_items[i][2] == true:
					for j : int in range($Body_Xray.get_child(1).get_child_count()):
						$Body_Xray.get_child(1).get_child(j).hide()
					$Body_Xray.get_child(1).get_child(Global.modified_items[i][1]).show()
				else:
					$Body_Xray.get_child(1).get_child(Global.modified_items[i][1]).hide()

func _on_is_dragged_button_down() -> void:
	dragging = true
	of_set = get_global_mouse_position() - global_position
	z_index = 10
	$CPUParticles2D.emitting = true

func _on_is_dragged_button_up() -> void:
	if is_target and in_jail:
		my_position = get_parent().get_parent().get_node("Jail").position
		droped_in_jail = true
		print("target in jail")
	elif in_jail:
		$WrongSound.play()
	dragging = false
	z_index = original_z_index
	$CPUParticles2D.emitting = false

func _on_is_dragged_pressed() -> void:
	if my_position.is_equal_approx(position):
		front_side = !front_side
		$Body_Front.visible = !$Body_Front.visible
		$Body_Back.visible = !$Body_Back.visible

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Jail"):
		in_jail = true
		if is_target:
			my_position = get_parent().get_parent().get_node("Jail").position
		print("Estoy en la carcer, soy ", is_target)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Jail"):
		print("Salí de la carcel")
		in_jail = false
