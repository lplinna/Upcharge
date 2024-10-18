@tool
extends Node2D
class_name PipeZone

@onready var closed_sprite = preload("res://Assets/Pipes/JPipes/greendot.png")
@onready var horizontal_sprite = preload("res://Assets/Pipes/PipeGrate.png")
@onready var vertical_sprite = preload("res://Assets/Pipes/PipeGrateBottom.png")

enum FACING {
	UP,
	LEFT,
	DOWN,
	RIGHT
}

var facing_vector = {
 FACING.UP: Vector2.UP,
 FACING.LEFT: Vector2.LEFT,
 FACING.DOWN: Vector2.DOWN,
 FACING.RIGHT: Vector2.RIGHT
}

@export var direction: FACING:
	set(value):
		direction = value
		match value:
			FACING.LEFT:
				$Sprite2D.texture = horizontal_sprite
				$Sprite2D.flip_h = false
			FACING.RIGHT:
				$Sprite2D.texture = horizontal_sprite
				$Sprite2D.flip_h = true
			FACING.UP:
				$Sprite2D.texture = vertical_sprite
				$Sprite2D.flip_v = true
			FACING.DOWN:
				$Sprite2D.texture = vertical_sprite
				$Sprite2D.flip_v = false


var neighbors: Array[PipeZone] 

var stop_eating: bool = false
var selectable: bool = true
var stored_player: Player = null
var player_there: bool = false
var closed: bool = true:
	set(new_closed):
		closed = new_closed
		if not new_closed:
			#$Sprite2D.texture = open_sprite
			pass


func shoot_grate():
	var new_grate_position = self.global_position + (facing_vector[direction] * 18)
	new_grate_position += (Vector2.DOWN * 200)
	var new_t = get_tree().create_tween()
	new_t.tween_property($Sprite2D,"global_position",new_grate_position,3.0)
	new_t.parallel().tween_property($Sprite2D,"rotation", 45 * [-1,1].pick_random(), 3.0)
	await new_t.finished
	$Sprite2D.visible = false


func show_e_prompt():
	$TheE.visible = true
	await get_tree().create_timer(4.0).timeout
	$TheE.visible = false


func _ready():
	direction = direction
	stored_player = get_tree().get_first_node_in_group("Player")
	stored_player.shop_pop_up.item_purchased.connect(func(item: int):
		if item == 1:
			show_e_prompt()
	)
	for node in get_parent().get_children():
		if node is PipeZone and node != self:
			neighbors.append(node)

func move_player_here():
	closed = false
	stored_player.frozen = true
	stored_player.animator.state = stored_player.animator.animation_state.ENTERED
	await stored_player.animator.animation_finished
	stored_player.global_position = self.global_position
	stored_player.animator.state = stored_player.animator.animation_state.ESCAPED
	shoot_grate()
	await stored_player.animator.animation_finished
	stored_player.frozen = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("return") and player_there:
		if closed and stored_player.held_item == 1:
			closed = false
			stored_player.use_item(1)
			shoot_grate()
		if not closed:
			var next_neighbor = neighbors.pick_random()
			next_neighbor.move_player_here()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_there = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_there = false
