@tool
extends Node2D
class_name Pipe

#@onready var body: Sprite2D = $PipeBody
#@onready var end1 = $End1
#@onready var end2 = $End2
#@onready var collision = $StaticBody2D/CollisionShape2D
#
#@onready var rivet_sprite: Sprite2D = $Rivets/RivetSprite
#@onready var rivets = $Rivets
#
#@onready var width = body.texture.get_width()

@export var is_vert: bool
@export var platform_length: float = 450.0:
	get:
		return platform_length
	set(value):
		platform_length = value
		set_pipe_length(value)
		set_ends(value)
		place_rivet_rings()

const pipe_width = 500
const offset = -6
const height = 76

func _ready():
	$Rivets.visible = false
	$StaticBody2D/CollisionShape2D.shape.size.y = height
	
func set_pipe_length(value):
	var scale_factor = value / $PipeBody.texture.get_width()
	$PipeBody.scale.x = scale_factor
	if !is_vert:
		$StaticBody2D/CollisionShape2D.shape.size.x = value
	else:
		$StaticBody2D/CollisionShape2D.shape.size.y = value
	
func set_ends(value):
	if !is_vert:
		$End1.position.x = -value / 2 - offset
		$End2.position.x = value / 2 + offset
	else:
		$End1.position.y = -value / 2 - offset
		$End2.position.y = value / 2 + offset


func place_rivet_rings():
	var num_rivets = floor($PipeBody.texture.get_width() / pipe_width)
	if num_rivets > 0:
		$Rivets.visible = true
		$Rivets.position.x = pipe_width - offset
	
		if num_rivets > 1:
			for i in range(num_rivets):
				var clone = $Rivets/RivetSprite.duplicate()
				clone.position.x = pipe_width + (i * pipe_width) - offset
				$Rivets.add_child(clone)
