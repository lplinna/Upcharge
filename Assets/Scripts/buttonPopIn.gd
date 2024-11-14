extends Button

@export var start_delay: float = 0.0

func _ready():

	# Create a Tween instance bound to this node
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0)
	
	# Set the pivot to the center of the button
	pivot_offset = size / 2

	# Wait for 1 second before starting the animation
	tween.tween_interval(start_delay)

	# Animate the scale from (0,0) to (1.2,1.2) scaling from the center
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	
	# Animate the scale from (1.2,1.2) back to (1,1)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.15).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
