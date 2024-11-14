extends Node2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.rotate(randf_range(0.0, 2*PI))
