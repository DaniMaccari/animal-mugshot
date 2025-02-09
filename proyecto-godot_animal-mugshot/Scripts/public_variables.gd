extends Node

const BODY_INDEX : int = 0

# [front, back, xray], [parte del cuerpo, item, si/no lo tiene]
var modified_items : Array = [[0, 0, false], [0, 0, false], [0, 0, false]]

var max_items : Array =  [
	[4, 4], # body
	[4], # back
	[1] # xray
]
