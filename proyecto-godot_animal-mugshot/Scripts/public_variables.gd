extends Node

const BODY_INDEX : int = 0
var is_playing = true
var reseting_level : bool = false

# [front, back, xray], [parte del cuerpo, item, si/no lo tiene]
var modified_items : Array = [[0, 0, false], [0, 0, false], [0, 0, false]]
var selected_items : Array = [[0, 0, 0, false], [0, 0, 0, false], [0, 0, 0, false]]

var max_items : Array =  [
	[6, 6], # body
	[3], # back
	[1] # xray
]
