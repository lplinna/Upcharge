extends Camera2D

## Reference to player.
@export var player_ref: Player

func _process(delta):
	var half_screen = (0.5 * get_viewport_rect().size.y)
	var top_screen = self.position.y - half_screen * 0.5
	var bottom_screen =  self.position.y + half_screen
	if player_ref.position.y < top_screen or player_ref.position.y > bottom_screen:
		position.y = player_ref.position.y - (half_screen * 0.7)
