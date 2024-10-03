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
	var player = get_tree().get_first_node_in_group("Player")
	player.global_position = self.global_position


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		if selectable:
			closed = false
			move_player_here()
