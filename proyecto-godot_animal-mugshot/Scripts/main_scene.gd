extends Node2D

const suspects_num : int = 3
var all_mugshots : Array = []

# Array safe body parts [ head, face,
var safe_items : Array = [-1, -1, -1, -1]
@onready var mugshot_positions: Node2D = $Mugshot_Positions
const MUGSHOT_SCENE: PackedScene = preload("res://Scenes/mugshot.tscn")

func _ready() -> void:
	Update_Mugshots()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Update_Mugshots() -> void:
	
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
		
		var new_mugshot = MUGSHOT_SCENE.instantiate()
		$Mugshots_Canvas.add_child(new_mugshot)
		
		var marker: Marker2D = mugshot_positions.get_child(i)
		new_mugshot.position = marker.position
		new_mugshot.set_grid_position(marker.position)
		
		all_mugshots.append(new_mugshot)
