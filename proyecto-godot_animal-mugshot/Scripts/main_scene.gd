extends Node2D

const suspects_num : int = 3
const max_item : int = 1
var all_mugshots : Array = []
var num_target : int

# Array safe body parts [ head, face, back, xray
var safe_items : Array = [-1, -1, -1, -1]
@onready var mugshot_positions: Node2D = $Mugshot_Positions
const MUGSHOT_SCENE: PackedScene = preload("res://Scenes/mugshot.tscn")

func _ready() -> void:
	Update_Mugshots()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Update_Props() -> void:
	for i : int in range(safe_items.size()):
		safe_items[i] = randi_range(0, 1)
		

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
