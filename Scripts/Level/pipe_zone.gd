extends Node2D
class_name PipeZone

@onready var open_sprite = preload("res://icon.svg")
@onready var closed_sprite = preload("res://Assets/Pipes/JPipes/greendot.png")

var neighbors: Array[PipeZone] 

var closed: bool = true
var selectable: bool = true


func _ready():
	for node in get_parent().get_children():
		if node is PipeZone and node != self:
			neighbors.append(node)
	print(neighbors)

func move_player_here():
	var player = get_tree().root.find_child("Player")
	player.global_position = self.global_position


func _on_button_pressed() -> void:
	print("glorbus")
	if selectable:
		closed = false
		move_player_here()
		
	pass # Replace with function body.
