extends Node

const BODY_INDEX : int = 0
# Array safe body parts [ head, torso, back, xray]
# pair [has_item, wich_item]
var selected_items : Array = [
	[[ -1, -1], [ -1, -1]], # body
	[[-1, -1]], # back
	[[-1, -1]] # xray
]

# [front, back, xray], [parte del cuerpo, item, si/no lo tiene]
var modified_items : Array = [[0, 0, false], [0, 0, false], [0, 0, false]]
var max_items : Array =  [
	[2, 2], # body
	[2], # back
	[1] # xray
]
