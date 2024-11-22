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
var PipeTravel

var audio_coin_collect
var audio_player_jump
var audio_player_walk
var audio_player_splash
var audio_player_land
var audio_PipeTravel
var audio_PipeCap
#signal done

func CoinCollect():
	var audio_coin_collect = AudioStreamPlayer.new()
	var randcoinsound = randi_range(1,6)
	CoinSound = load("res://Resources/Sounds/Coins/Pick up Coins-0"+str(randcoinsound)+".wav")
	audio_coin_collect.set_script(SoundScript)
	audio_coin_collect.volume_db = -10
	audio_coin_collect.stream = CoinSound
	#print("COIN GET!")
	
	add_child(audio_coin_collect)
	audio_coin_collect.play()
	#await audio_coin_collect.finished
	#emit_signal("done")
	return audio_coin_collect

func PlayerJump(power):
	var audio_player_jump = AudioStreamPlayer.new()
	var randjumpsound = randi_range(1,6)
	JumpSound = load("res://Resources/Sounds/Jumps/Jump_Squeak_ Echo_0"+str(randjumpsound)+".wav")
	audio_player_jump.set_script(SoundScript)
	audio_player_jump.pitch_scale = 2.0 - power
	audio_player_jump.volume_db = -20
	audio_player_jump.stream = JumpSound
	#print("BOING")
	add_child(audio_player_jump)
	audio_player_jump.play()
	#await audio_player_jump.finished
	#emit_signal("done")
	return audio_player_jump

func PlayerWalk():
	var audio_player_walk = AudioStreamPlayer.new()
	var randwalksound = randi_range(1,11)
	WalkSound = load("res://Resources/Sounds/Walking/Rat_Walking_"+str(randwalksound)+".wav")
	audio_player_walk.set_script(SoundScript)
	audio_player_walk.volume_db = -10
	audio_player_walk.stream = WalkSound
	#print("STEP")
	add_child(audio_player_walk)
	audio_player_walk.play()
	#await audio_player_walk.finished
	#emit_signal("done")
	return audio_player_walk

func PlayerWalkPuddle():
	var audio_player_splash = AudioStreamPlayer.new()
	var randwalksound = randi_range(1,7)
	WalkSound = load("res://Resources/Sounds/Walking/Puddled/Walking_Puddled_0"+str(randwalksound)+".wav")
	audio_player_splash.set_script(SoundScript)
	audio_player_splash.volume_db = -10
	audio_player_splash.stream = WalkSound
	#print("STEP")
	add_child(audio_player_splash)
	audio_player_splash.play()
	#await audio_player_splash.finished
	#emit_signal("done")
	return audio_player_splash

func PlayerLand(fall_length):
	audio_player_land = AudioStreamPlayer.new()
	var randSplat = randi_range(1,3)
	var randwalksound = randi_range(1,11)
	if fall_length == "long":
		SplatSound = load("res://Resources/Sounds/Jumps/Landings/Fall_Pain_Ground_Impact_0"+str(randSplat)+".wav")
	elif fall_length == "short":
		SplatSound = load("res://Resources/Sounds/Walking/Rat_Walking_"+str(randwalksound)+".wav")
	audio_player_land.set_script(SoundScript)
	audio_player_land.volume_db = -10
	audio_player_land.stream = SplatSound
	add_child(audio_player_land)
	audio_player_land.play()
	#await audio_stream_player.finished
	#emit_signal("done")
	return audio_player_land

func PlayerPipeTravel():
	audio_PipeTravel = AudioStreamPlayer.new()
	var randpipesound = randi_range(1,5)
	PipeTravel = load("res://Resources/Sounds/Pipe_Travel/SFX_Single_Shot_IN_PIPE_0"+str(randpipesound)+".wav")
	audio_PipeTravel.set_script(SoundScript)
	audio_PipeTravel.stream = PipeTravel
	add_child(audio_PipeTravel)
	audio_PipeTravel.play()
	#await audio_PipeTravel.finished
	#emit_signal("done")
	return audio_PipeTravel

func PipeCap():
	audio_PipeCap = AudioStreamPlayer.new()
	var randPipeCap = randi_range(1,8)
	var PipeCap = load("res://Resources/Sounds/Pipe_Travel/Pipe_Cap/SFX_Pipe_Cap_0"+str(randPipeCap)+".wav")
	audio_PipeCap.set_script(SoundScript)
	audio_PipeCap.stream = PipeCap
	audio_PipeCap.volume_db = 5
	add_child(audio_PipeCap)
	audio_PipeCap.play()
	#await audio_PipeCap.finished
	#emit_signal("done")
	return audio_PipeCap
