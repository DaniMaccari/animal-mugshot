extends Node2D

const suspects_num : int = 3
const max_item : int = 1
const max_atributes : int = 3
var all_mugshots : Array = []
var num_target : int

@onready var mugshot_positions: Node2D = $Mugshot_Positions
const MUGSHOT_SCENE: PackedScene = preload("res://Scenes/mugshot.tscn")

func _ready() -> void:
	Update_Props()
	Update_Mugshots()
	$UI.Set_Timer()
	pass

func _process(delta: float) -> void:
	pass


func Update_Props() -> void:
	# volver a 0
	Global.modified_items = [[0, 0, false], [0, 0, false], [0, 0, false]]
	
	for i : int in range(Global.modified_items.size()):
		var body_part : int = 1
		var wich_item : int = randi_range(0, Global.max_items[i][0] -1) # DEBUG esto puede dar error
		var it_has : bool = randi() % 2 == 0
		
		if i == 0:
			body_part = randi_range(1, Global.max_items[i].size())
			
		Global.modified_items[i] = [body_part, wich_item, it_has]
		print("target_items ", Global.modified_items[i])
	

func Update_Mugshots() -> void:
	
	# clean old characters
	for mugshot in all_mugshots:
		if mugshot != null:
			mugshot.queue_free()
	all_mugshots.clear()
	
	# new characters
	num_target = randi_range(0, suspects_num -1)
	print("target1 ", num_target)
	
	for i : int in range(suspects_num):
		
		if i >= mugshot_positions.get_child_count():
			print("Advertencia: No hay suficientes posiciones Marker2D")
			break
		
		var new_character = MUGSHOT_SCENE.instantiate()
		if i == num_target:
			new_character.set_target()
			print("target2 ", num_target)
			
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
