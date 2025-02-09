extends Node2D




func _on_area_2d_area_entered(area: Area2D) -> void:
	$Jail_Door_Closed.hide()
	$Jail_Door_Open.show()
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	$Jail_Door_Open.hide()
	$Jail_Door_Closed.show()
	pass # Replace with function body.
