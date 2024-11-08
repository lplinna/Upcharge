extends Node2D

@onready var sprite = $Sprite
@onready var speech_bubble = $SpeechBubble

@onready var coin_ask: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_1.png")
#@onready var coin_ask2: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_3_.png")
@onready var coin_demand: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_2.png")
#@onready var coin_demand2: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_4.png")

@onready var bubble_plain: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_1_plain.png")
#@onready var bubble_plain_sharp: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_2_plain.png")
#@onready var bubble_plain_close: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_3_plain.png")
#@onready var bubble_plain_lumpy: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_4_plain.png")

@onready var particles = $CoinParticles

var coins_paid = false
var payment_ready = false

func _ready() -> void:
	# Leaving a valid texture is useful for placement in-level, so we reset it
	# to empty here, and dynamically load it back later 
	speech_bubble.texture = null
	
func _process(delta: float) -> void:
	if payment_ready:
		if Input.is_action_just_released("interact"):
			particles.visible = true

## defunct winzone code
#@export var coins_to_win: int = 4
#
#var win_state: bool = false
#
#func _on_area_2d_body_entered(body):
#	if body is Player and not win_state:
#		if body.coins >= coins_to_win or body.held_item == 3:
#			win_state = true
#			$CenterContainer/YouWin.visible = true
#			$CenterContainer/NotEnough.visible = false
#			await get_tree().create_timer(2.0).timeout
#			get_tree().change_scene_to_file("res://Scenes/Level/MainMenu.tscn")
#		else:
#			$CenterContainer/NotEnough.visible = true
#			await get_tree().create_timer(2.0).timeout
#			$CenterContainer/NotEnough.visible = false
#			get_tree().change_scene_to_file("res://Scenes/Level/level_01.tscn")


func _on_speech_zone_body_entered(body: Node2D) -> void:
	print('speech zone entered')
	speech_bubble.visible = true
	speech_bubble.texture = coin_ask
	payment_ready = true
	


func _on_speech_zone_body_exited(body: Node2D) -> void:
	payment_ready = false
	speech_bubble.visible = false
