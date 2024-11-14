extends Node2D

@onready var player = $"../Player"

var minHeight

func _ready():
	minHeight = global_position.y
	print(minHeight)

func _process(delta):
	if player.global_position.y < minHeight:
		global_position.y = player.global_position.y
	global_position.x = player.global_position.x
	#print(global_position.x)
	#print(global_position.y)
