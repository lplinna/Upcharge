extends Camera2D

## Reference to player.
@export var player_ref: Player

## Enum for camera behavior.
enum camera_mode {
	JUMP_KING,
	SIMPLE,
	X_LOCKED
}

## Chosen camera behavior.
@export var current_mode: camera_mode

func _process(delta):
	match current_mode:
		camera_mode.JUMP_KING:
			var top_screen = self.position.y - (0.5 * get_viewport_rect().size.y)
			var bottom_screen =  self.position.y + (0.5 * get_viewport_rect().size.y)
			if player_ref.position.y < top_screen or player_ref.position.y > bottom_screen:
				position.y = player_ref.position.y
		camera_mode.SIMPLE:
			position = player_ref.position
		camera_mode.X_LOCKED:
			position.y = player_ref.position.y
