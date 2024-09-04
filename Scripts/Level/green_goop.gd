extends Node2D

func _on_area_2d_body_entered(body):
	if body is Player:
		body.horizontal_lethargy = 0.05 #the lower the value the more slipery the goop.

func _on_area_2d_body_exited(body):
	if body is Player:
		body.horizontal_lethargy = 0.2 #the given default value in the player.gd script.
