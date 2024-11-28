extends Node2D


@onready var coin_ask: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_1.png")
#@onready var coin_ask2: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_3_.png")
@onready var coin_demand: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_2.png")
#@onready var coin_demand2: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_4.png")

@onready var bubble_plain: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_1_plain.png")
#@onready var bubble_plain_sharp: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_2_plain.png")
#@onready var bubble_plain_close: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_3_plain.png")
#@onready var bubble_plain_lumpy: CompressedTexture2D = preload("res://Assets/Guard/Speech Bubbles/Guard_Rat_Bubble_4_plain.png")

@onready var guard_voice_ask: AudioStreamWAV = preload("res://Resources/Sounds/Speech/Rat_King/SFX_Rat_King_02.wav")
@onready var guard_voice_no: AudioStreamWAV = preload("res://Resources/Sounds/Speech/Rat_King/SFX_Rat_King_03.wav")
@onready var guard_voice_yes: AudioStreamWAV = preload("res://Resources/Sounds/Speech/Rat_King/SFX_Rat_King_04.wav")

@onready var sprite = $Sprite
@onready var speech_bubble = $SpeechBubble
@onready var textLabel = $SpeechBubble/Label
@onready var cheese = $SpeechBubble/Cheese
@onready var particles = $CoinParticles
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area: Area2D = $SpeechZone

@export var exit_price: int = 10

var payment_ready := false
var can_interact := false

signal toll_paid

func _ready() -> void:
	# Leaving a valid texture is useful for placement in-level, so we reset it
	# to empty here, and dynamically load it back later 
	speech_bubble.texture = null
	textLabel.visible = false
	cheese.visible = false
	
func _process(delta: float) -> void:
	if !can_interact:
		return
	
	if Input.is_action_just_released("interact"):
		if payment_ready:
			particles.visible = true
			emit_signal("toll_paid")
			audio.stream = guard_voice_yes
			audio.play()
			speech_bubble.visible = false
			cheese.visible = false
			textLabel.visible = false
			area.monitoring = false
		else:
			audio.stream = guard_voice_no
			audio.play()

func _on_speech_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		can_interact = true
		speech_bubble.visible = true
		audio.stream = guard_voice_ask
		
		if "Cheese" in body.items: 
			speech_bubble.texture = bubble_plain
			textLabel.visible = true
			textLabel.text = "?"
			cheese.visible = true
			payment_ready = true
		else:
			speech_bubble.texture = coin_ask
			
			if body.coins >= exit_price:
				payment_ready = true
				
		audio.play()


func _on_speech_zone_body_exited(body: Node2D) -> void:
	can_interact = false
	speech_bubble.visible = false
