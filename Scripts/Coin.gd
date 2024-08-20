extends RigidBody2D
class_name Coin

const CoinCounter = preload("res://Scenes/coin_count.tscn")

var claimed: bool = false

func _on_area_2d_body_entered(body):
	if body is Player and not claimed:
		jump_collect(body)

## The coin jumps into the air and is collected
##
## Parameters:
##		player - the player that collected this coin.
func jump_collect(player: Player):
	claimed = true
	collision_layer = 0
	collision_mask = 0
	apply_impulse(Vector2(0,-300.0),Vector2(0,0))
	$CollectionTimer.start()
	await $CollectionTimer.timeout
	player.coins += 1
	print("COIN GET!")
	print(player.coins)
	queue_free()
	
