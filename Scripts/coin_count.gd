extends Sprite2D
class_name coin_count

@onready var label = $Label

func init(player_ref: Player):
	pass

func _process(delta):
	label.text = "X %s" % get_parent().coins
	
