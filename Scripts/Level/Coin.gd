extends RigidBody2D
class_name Coin

const CoinCounter = preload("res://Scenes/Player/coin_count.tscn")

## using an audio placeholder until the actual sound is added.
## yes it's just me going "ding".
#const CoinCollectSound = preload("res://Resources/Sounds/coin_collect.wav")
#@onready var collectSound = $CollectSound

var claimed: bool = false


func _ready() -> void:
	await get_tree().create_timer(randf()*2.5).timeout
	$Sprite2D.play("default")

func _on_area_2d_body_entered(body):
	if body is Player and not claimed:
		jump_collect(body)
		#collectSound.stream = CoinCollectSound
		#collectSound.play()
		SoundManager.CoinCollect()

## The coin jumps into the air and is collected
##
## Parameters:
##		player - the player that collected this coin.
func jump_collect(player: Player):
	$Sprite2D.play("pickup")
	claimed = true
	collision_layer = 0
	collision_mask = 0
	apply_impulse(Vector2(0,-300.0),Vector2(0,0))
	$CollectionTimer.start()
	
	await $CollectionTimer.timeout
	player.coins += 20
	#print("COIN GET!")
	#print(player.coins)
	queue_free()
	
