extends Node2D

const suspects_num : int = 10
const max_item : int = 1
const max_atributes : int = 3
var all_mugshots : Array = []
var num_target : int


@onready var mugshot_positions: Node2D = $Mugshot_Positions
const MUGSHOT_SCENE: PackedScene = preload("res://Scenes/mugshot.tscn")

func _ready() -> void:
	$Cortinas.show()
	$Game_Menu.Show_Menu()
	
	$Mugshots_Canvas.entered_jail.connect(New_Round)
	$UI.time_ended.connect(Game_Over)
	pass

func New_Game() -> void:
	
	Global.is_playing = true
	$Game_Menu.Hide_Menu()
	$Cortinas.show()
	Update_Props()
	Update_Folders()
	Update_Mugshots()
	$UI.Set_Timer()
	$Cortinas.Open_Curtains()
	$Music_BG.pitch_scale = 1.0
	
	
func New_Round() -> void:
	if Global.reseting_level == false:
		Global.reseting_level = true
		print("new_round")
		# cerrar cortinas
		$Cortinas.Close_Curtains()
		$Sound_Clap.play()
		$UI.Add_Time(50)
		await get_tree().create_timer(1.0).timeout
		
		# actualizar todo
		Update_Props()
		Update_Folders()
		Update_Mugshots()
		
		await get_tree().create_timer(0.2).timeout
		$Cortinas.Open_Curtains()

func Game_Over() -> void:
	if Global.is_playing:
		Global.is_playing = false
		print("Game Over")
		$Game_Menu.Show_Menu()
		$Cortinas.Game_Over()
		#$Music_BG.stop()
		$Music_BG.pitch_scale = 0.8

func Update_Props1() -> void:
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

func Update_Props() -> void:
	# resetear array
	Global.selected_items = [[0, 0, 0, false], [0, 0, 0, false], [0, 0, 0, false]]
	
	for i : int in range(Global.selected_items.size()):
		var body_section_array : Array = [0, 0, 1, 2]
		var body_part_array : Array = [1, 2, 1, 1]
		
		var body_section : int = body_section_array[i]
		var body_part : int = body_part_array[i]
		var wich_item : int = randi_range(0, Global.max_items[i][0] -1) # DEBUG esto puede dar error
		var it_has : bool = randi() % 2 == 0
		
		Global.selected_items[i] = [body_section, body_part, wich_item, it_has]
		print("target_items ", Global.selected_items[i])
	
func Update_Folders1() -> void:
	# $Floders.get_child( número de carpeta )
	var empty_folder : int = randi_range(0, 3)
	var item_counter : int = 0
	
	for folder_num : int in range($Folders.get_child_count()):
		$Folders.get_child(folder_num).clean_folder()
		$Folders.get_child(folder_num).position = $Folders_Position.get_child(folder_num).position
		
		if folder_num == empty_folder:
			$Folders.get_child(folder_num).get_child(4).show()
		else:
			# Global.modified_items[x] 0 Front, 1 Back, 2 Xray
			# Global.modified_items[x] Parte del cuerpo
			$Folders.get_child(folder_num).get_child(item_counter).get_child(Global.modified_items[item_counter][0]).get_child(Global.modified_items[item_counter][1]).show()
			# sello si/no
			if Global.modified_items[item_counter][2]:
				$Folders.get_child(folder_num).get_child(3).get_child(0).show()
			else:
				$Folders.get_child(folder_num).get_child(3).get_child(1).show()
			
			item_counter += 1

func Update_Folders() -> void:
	var empty_folder1 : int = randi_range(0, 2) # 3 carpetas
	var empty_folder2 : int = randi_range(3, 4) # 2 carpetas
	var item_counter : int = 0
	
	for folder_num : int in range($Folders.get_child_count()):
		$Folders.get_child(folder_num).clean_folder()
		$Folders.get_child(folder_num).position = $Folders_Position.get_child(folder_num).position
		
		if folder_num == empty_folder1 || folder_num == empty_folder2:
			$Folders.get_child(folder_num).get_child(4).show()
		else:
			# Global.modified_items[] 0 Front, 1 Back, 2 Xray
			# Global.modified_items[x] Parte del cuerpo
			var body_section : int = Global.selected_items[item_counter][0]
			var body_part : int = Global.selected_items[item_counter][1]
			var wich_item : int = Global.selected_items[item_counter][2]
			var it_has : bool = Global.selected_items[item_counter][3]
			$Folders.get_child(folder_num).get_child(body_section).get_child(body_part).get_child(wich_item).show()
			
			# sello si/no
			if it_has:
				$Folders.get_child(folder_num).get_child(3).get_child(0).show()
			else:
				$Folders.get_child(folder_num).get_child(3).get_child(1).show()
			
			item_counter += 1
	

func Update_Mugshots() -> void:
	
	# clean old characters
	for mugshot in all_mugshots:
		if mugshot != null:
			mugshot.queue_free()
	all_mugshots.clear()
	
	# new characters
	num_target = randi_range(0, suspects_num -1)
	print("TARGET IS ", num_target)
	
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


func _on_start_game_button_pressed() -> void:
	New_Game()
	pass # Replace with function body.
