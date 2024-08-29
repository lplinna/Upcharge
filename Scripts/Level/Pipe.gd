extends Node2D
class_name Pipe

@onready var body: Sprite2D = $PipeBody
@onready var left = $Left
@onready var right = $Right
@onready var collision = $StaticBody2D/CollisionShape2D

@onready var rivet_sprite: Sprite2D = $Rivets/RivetSprite
@onready var rivets = $Rivets

@onready var width = body.texture.get_width()

@export var platform_length: float = 450.0
var _platform_length: float:
	get:
		return platform_length
	set(value):
		var scale_factor = platform_length / width
		body.scale.x = scale_factor
		platform_length = value
		collision.shape.size.x = value
		left.position.x = -platform_length / 2 - offset
		right.position.x = platform_length / 2 + offset
		place_rivet_rings()

const pipe_width = 500
const offset = 10
const height = 100

func _ready():
	rivets.visible = false
	collision.shape.size.y = height
	
	# ensures @onready vars are set before applying platform_length
	_platform_length = platform_length


func place_rivet_rings():
	var num_rivets = floor(width / pipe_width)
	if num_rivets > 0:
		rivets.visible = true
		rivets.position.x = pipe_width - offset
	
		if num_rivets > 1:
			for i in range(num_rivets):
				var clone = rivet_sprite.duplicate()
				clone.position.x = pipe_width + (i * pipe_width) - offset
				rivets.add_child(clone)
