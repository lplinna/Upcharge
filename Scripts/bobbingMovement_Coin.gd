extends AnimatedSprite2D

@export var bob_frequency: float = 1.0  # Frequency of the bobbing (in seconds)
@export var bob_height: float = 20.0    # Height of the bobbing effect (in pixels)

func _ready() -> void:
	# Create a Tween instance bound to this node
	var tween = create_tween()

	# Store the original position
	var original_position = position

	# Animate the TextureRect bobbing up and down
	# Bob up
	tween.tween_property(self, "position:y", original_position.y - bob_height, bob_frequency / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Bob down
	tween.tween_property(self, "position:y", original_position.y, bob_frequency / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Repeat the tween indefinitely
	tween.set_loops()
