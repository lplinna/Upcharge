extends Node

#old place holder sounds
#const CoinCollectSound = preload("res://Resources/Sounds/coin_collect.wav")
#const PlayerJumpSound = preload("res://Resources/Sounds/player_jump.wav")
#const PlayerWalkSound = preload("res://Resources/Sounds/Player_step.wav")

const SoundScript = preload("res://Scripts/sound.gd")

var CoinSound
var JumpSound
var WalkSound
var SplatSound

func CoinCollect():
	var audio_stream_player = AudioStreamPlayer.new()
	var randcoinsound = randi_range(1,6)
	CoinSound = load("res://Resources/Sounds/Coins/Pick up Coins-0"+str(randcoinsound)+".wav")
	audio_stream_player.set_script(SoundScript)
	audio_stream_player.volume_db = -10
	audio_stream_player.stream = CoinSound
	#print("COIN GET!")
	
	add_child(audio_stream_player)
	audio_stream_player.play()

func PlayerJump(power):
	var audio_stream_player = AudioStreamPlayer.new()
	var randjumpsound = randi_range(1,6)
	JumpSound = load("res://Resources/Sounds/Jumps/Jump_Squeak_ Echo_0"+str(randjumpsound)+".wav")
	audio_stream_player.set_script(SoundScript)
	audio_stream_player.pitch_scale = 2.0 - power
	audio_stream_player.volume_db = -20
	audio_stream_player.stream = JumpSound
	#print("BOING")
	
	add_child(audio_stream_player)
	audio_stream_player.play()

func PlayerWalk():
	var audio_stream_player = AudioStreamPlayer.new()
	var randwalksound = randi_range(1,11)
	WalkSound = load("res://Resources/Sounds/Walking/Rat_Walking_"+str(randwalksound)+".wav")
	audio_stream_player.set_script(SoundScript)
	audio_stream_player.volume_db = -10
	audio_stream_player.stream = WalkSound
	#print("STEP")
	
	add_child(audio_stream_player)
	audio_stream_player.play()

func PlayerWalkPuddle():
	var audio_stream_player = AudioStreamPlayer.new()
	var randwalksound = randi_range(1,7)
	WalkSound = load("res://Resources/Sounds/Walking/Puddled/Walking_Puddled_0"+str(randwalksound)+".wav")
	audio_stream_player.set_script(SoundScript)
	audio_stream_player.volume_db = -10
	audio_stream_player.stream = WalkSound
	#print("STEP")
	
	add_child(audio_stream_player)
	audio_stream_player.play()

func PlayerLand(fall_length):
	var audio_stream_player = AudioStreamPlayer.new()
	var randSplat = randi_range(1,3)
	var randwalksound = randi_range(1,11)
	if fall_length == "long":
		SplatSound = load("res://Resources/Sounds/Jumps/Landings/Fall_Pain_Ground_Impact_0"+str(randSplat)+".wav")
	elif fall_length == "short":
		SplatSound = load("res://Resources/Sounds/Walking/Rat_Walking_"+str(randwalksound)+".wav")
	audio_stream_player.set_script(SoundScript)
	audio_stream_player.volume_db = -10
	audio_stream_player.stream = SplatSound
	
	add_child(audio_stream_player)
	audio_stream_player.play()
