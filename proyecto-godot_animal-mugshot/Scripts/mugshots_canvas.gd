extends Node2D

signal entered_jail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Entered_Jail() -> void:
	emit_signal("entered_jail")
