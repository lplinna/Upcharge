@tool
extends Node2D
class_name Pipe

var pipe_end_h = preload("res://Assets/Pipes/JPipes/EndH.png")
var pipe_end_v = preload("res://Assets/Pipes/JPipes/EndV.png")
#var pipe_end_curve_r = preload("res://Assets/Pipes/RightPipeSmall.png")
var pipe_body_v = preload("res://Assets/Pipes/JPipes/PipeV.png")
var pipe_body_h = preload("res://Assets/Pipes/JPipes/PipeH.png")

#const pipe_width = 500
#const offset = -6
#const h_offset = 10
const height = 70

enum EndType
{
	NONE,
	VERT,
	HORZ
}

@export var show_rivets: bool:
	set(value):
		$Rivets.visible = value
		show_rivets = value


@export var is_vert: bool:
	set(value):
		is_vert = value
		if (value):
			$PipeBody.rotation = 90 * PI/180
			$PipeBody.texture = pipe_body_v
		else:
			$PipeBody.rotation = 0
			$PipeBody.texture = pipe_body_h
		# trigger other updates
		platform_length = platform_length
	get:
		return is_vert

@export var End1Type: EndType:
	set(value):
		End1Type = value
		set_pipe_type(value, $End1/EndSprite)
	get:
		return End1Type

@export var End2Type: EndType:
	set(value):
		End2Type = value
		set_pipe_type(value, $End2/EndSprite)
		if value == EndType.HORZ:
			$End2/EndSprite.flip_v = true
			
		$End2/EndSprite.rotation = 180 * PI/180

	get:
		return End2Type

func set_pipe_type(value, sprite_to_update):
	match value:
			EndType.VERT:
				sprite_to_update.texture = pipe_end_v
			EndType.HORZ:
				sprite_to_update.texture = pipe_end_h
			_:
				sprite_to_update.texture = null

@export var platform_length: float = 450.0:
	get:
		return platform_length
	set(value):
		platform_length = value
		set_pipe_length(value)
		set_ends(value)
		#place_rivet_rings()

func _ready():
	$Rivets.visible = false
	
func set_pipe_length(value):
	var scale_factor = value / $PipeBody.texture.get_width()
	$PipeBody.scale.x = scale_factor
	if !is_vert:
		$StaticBody2D/CollisionShape2D.shape.size.x = value
		$StaticBody2D/CollisionShape2D.shape.size.y = height
	else:
		$StaticBody2D/CollisionShape2D.shape.size.y = value
		$StaticBody2D/CollisionShape2D.shape.size.x = height
	
func set_ends(value):
	if !is_vert:
		$End1.position.x = -value / 2# - offset + h_offset
		$End2.position.x = value / 2# + offset - h_offset
		
		$End1.position.y = 0
		$End2.position.y = 0
		
	else:
		$End1.position.y = -value / 2# - offset
		$End2.position.y = value / 2# + offset
		
		$End1.position.x = 0
		$End2.position.x = 0


#func place_rivet_rings():
	#var num_rivets = floor($PipeBody.texture.get_width() / pipe_width)
	#if num_rivets > 0:
		#$Rivets.visible = true
		#$Rivets.position.x = pipe_width - offset
	#
		#if num_rivets > 1:
			#for i in range(num_rivets):
				#var clone = $Rivets/RivetSprite.duplicate()
				#clone.position.x = pipe_width + (i * pipe_width) - offset
				#$Rivets.add_child(clone)
