extends Camera2D

## Reference to player.
@export var player_ref: Player

func _process(delta):
	var full_screen_height = get_viewport_rect().size.y
	var center_line = position.y
	var difference = center_line - player_ref.position.y
	if abs(center_line - player_ref.position.y) > 0.25 * full_screen_height:
		position.y -= difference
