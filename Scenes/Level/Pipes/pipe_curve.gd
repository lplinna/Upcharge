@tool
extends Node2D

var top_left_texture = preload("res://Assets/Pipes/JPipes/TopL.png")
var top_right_texture = preload("res://Assets/Pipes/JPipes/TopR.png")
var bottom_left_texture = preload("res://Assets/Pipes/Jpipes/BotL.png")
var bottom_right_texture = preload("res://Assets/Pipes/JPipes/BotR.png")

enum Orientation {
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}

@export var orientation: Corner:
	set(value):
		orientation = value
		update_texture()
	get:
		return orientation

func _ready():
	update_texture()

func update_texture():
	match orientation:
		Orientation.TOP_LEFT:
			$Sprite2D.texture = top_left_texture
			$StaticBody2D/CollisionPolygon2D.rotation = 0
		Orientation.TOP_RIGHT:
			$Sprite2D.texture = top_right_texture
			$StaticBody2D/CollisionPolygon2D.rotation = deg_to_rad(90)
		Orientation.BOTTOM_LEFT:
			$Sprite2D.texture = bottom_left_texture
			$StaticBody2D/CollisionPolygon2D.rotation = deg_to_rad(270)
		Orientation.BOTTOM_RIGHT:
			$Sprite2D.texture = bottom_right_texture
			$StaticBody2D/CollisionPolygon2D.rotation = deg_to_rad(180)
