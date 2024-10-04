extends Node2D
class_name PipeZone

@onready var open_sprite = preload("res://icon.svg")
@onready var closed_sprite = preload("res://Assets/Pipes/JPipes/greendot.png")

var neighbors: Array[PipeZone] 

var stop_eating: bool = false
var closed: bool = true
var selectable: bool = true
var stored_player: Player = null
var player_there: bool = false


func _ready():
	stored_player = get_tree().get_first_node_in_group("Player")
	for node in get_parent().get_children():
		if node is PipeZone and node != self:
			neighbors.append(node)

func move_player_here():
	stored_player.global_position = self.global_position

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("return") and player_there:
		var next_neighbor = neighbors.pick_random()
		next_neighbor.move_player_here()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_there = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_there = false
