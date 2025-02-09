extends Node2D

const suspects_num : int = 3
const max_item : int = 1
const max_atributes : int = 3
var all_mugshots : Array = []
var num_target : int

@onready var mugshot_positions: Node2D = $Mugshot_Positions
const MUGSHOT_SCENE: PackedScene = preload("res://Scenes/mugshot.tscn")

func _ready() -> void:
	Update_Mugshots()
	pass

func _process(delta: float) -> void:
	pass


func Update_Props() -> void:
	#var num_atributes : int = max_atributes
	#while num_atributes > 0:
		#
		#pass
	for i : int in range(Global.selected_items.size()):
		# volver a 0
		Global.modified_items = [[0, 0, false], [0, 0, false], [0, 0, false]]
		
		var body_part : int = 1
		var wich_item : int = randi_range(0, Global.max_items[i])
		var it_has : int = randi()
		
		if i == 0:
			body_part = randi_range(1, Global.max_items[i].size())
			
		Global.modified_items[i] = [body_part, wich_item, it_has]

func Update_Mugshots() -> void:
	
	# select new bad
	num_target = randi_range(0, suspects_num)
	
	# clean old characters
	for mugshot in all_mugshots:
		if mugshot != null:
			mugshot.queue_free()
	all_mugshots.clear()
	
	# new characters
	for i : int in range(suspects_num):
		
		if i >= mugshot_positions.get_child_count():
			print("Advertencia: No hay suficientes posiciones Marker2D")
			break
		
		var new_character = MUGSHOT_SCENE.instantiate()
		if i == num_target:
			print("target ", i)
			new_character.set_target()
			
		new_character.Dress_Character()
		#Dress_Character(new_mugshot)
		$Mugshots_Canvas.add_child(new_character)
		
		var marker: Marker2D = mugshot_positions.get_child(i)
		new_character.position = marker.position
		new_character.set_grid_position(marker.position)
		
		all_mugshots.append(new_character)

func Dress_Character(character : PackedScene) -> void:
	
	#if character.is_target:
		##DEBUG
		#if safe_items[0] == 0:
			#character.
	pass

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_down"): #DEBUG
		Update_Props()
