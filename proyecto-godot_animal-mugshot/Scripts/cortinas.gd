extends Node2D

@onready var cortina_izq : Sprite2D = $Cortina
@onready var cortina_der : Sprite2D = $Cortina2

func Close_Curtains() -> void:
	var tween : Tween = create_tween()
	var center_x = get_viewport_rect().size.x / 2  # Centro de la pantalla

	tween.set_parallel(true)
	tween.tween_property(cortina_izq, "position:x", center_x - cortina_izq.texture.get_width() / 2, 1.0)
	tween.tween_property(cortina_der, "position:x", center_x + cortina_der.texture.get_width() / 2, 1.0)

func Open_Curtains() -> void:
	
	if Global.is_playing == false:
		return
	
	var tween : Tween = create_tween()
	var center_x = get_viewport_rect().size.x / 2  # Centro de la pantalla

	tween.set_parallel(true)
	tween.tween_property(cortina_izq, "position:x", $Marker.position.x, 1.0)
	tween.tween_property(cortina_der, "position:x", $Marker2.position.x, 1.0)
	
	Global.reseting_level = false
	
func Game_Over() -> void:
	Close_Curtains()
