extends Node2D


const angles = {
	0: preload("res://Assets/Pipes/TopLeftCurve.tres"),
	90: preload("res://Assets/Pipes/TopRightCurve.tres"),
	180: preload("res://Assets/Pipes/BottomRightCurve.tres"),
	270: preload("res://Assets/Pipes/BottomLeftCurve.tres"),
	-90: preload("res://Assets/Pipes/BottomLeftCurve.tres")
}



func _ready() -> void:
	return
	var choice = ceil(rad_to_deg(rotation) / 90)
	$Sprite2D.texture = angles[int(choice * 90)]
	$Sprite2D.rotation -= deg_to_rad(180)
