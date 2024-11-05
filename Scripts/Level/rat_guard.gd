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

func _ready() -> void:
	# Leaving a valid texture is useful for placement in-level, so we reset it
	# to empty here, and dynamically load it back later 
	speech_bubble.texture = null


func _on_speech_zone_area_entered(area: Area2D) -> void:
	print('speech zone entered')
	speech_bubble.texture = coin_ask
