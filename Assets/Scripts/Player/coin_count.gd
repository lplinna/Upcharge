extends Sprite2D
class_name CoinCount

@onready var label = $Label

func _process(delta):
	label.text = "X %s" % get_parent().coins
	
