extends Node2D
class_name PipeZone

@onready var open_sprite = preload("res://icon.svg")
@onready var closed_sprite = preload("res://Assets/Pipes/JPipes/greendot.png")

var neighbors: Array[PipeZone] 

var stop_eating: bool = false
var closed: bool = true
var selectable: bool = false
var stored_player: Player = null


func _ready():
	stored_player = get_tree().get_first_node_in_group("Player")
	for node in get_parent().get_children():
		if node is PipeZone and node != self:
			neighbors.append(node)
	print(neighbors)

func move_player_here():
	stored_player.global_position = self.global_position
	get_tree().root.add_child(stored_player)


func make_neighbors_selectable():
	for neighbor in neighbors:
		neighbor.selectable = true
		neighbor.stop_eating = true
		

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		if selectable:
			closed = false
			move_player_here()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if stop_eating:
		return
	if body is Player:
		body.get_parent().remove_child(body)
		make_neighbors_selectable()
