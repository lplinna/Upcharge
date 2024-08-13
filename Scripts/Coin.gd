extends RigidBody2D
class_name Coin


func _on_area_2d_body_entered(body):
	if body is Player:
		jump_collect()

func jump_collect():
	print("Collecting")
	collision_layer = 0
	collision_mask = 0
	apply_impulse(Vector2(0,-300.0),Vector2(0,0))
	$CollectionTimer.start()
	await $CollectionTimer.timeout
	queue_free()
	
