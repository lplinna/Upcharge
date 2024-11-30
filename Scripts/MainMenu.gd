extends Control

@onready var main_menu = $ActualMainMenu
@onready var instructions = $Instructions
@onready var credits = $Credits
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer

var sounds = preload("res://Scripts/sound.gd")

@export var smoke_speed : float = 50.0 
var motion_offset : Vector2

const smoke_x_limit = 2474
const smoke_x_start = 0

func _ready():
	motion_offset = parallax_layer.motion_offset

func _process(delta):
	motion_offset.x += smoke_speed * delta 

	parallax_layer.motion_offset = motion_offset

	if motion_offset.x > smoke_x_limit: 
		motion_offset.x = smoke_x_start 


func _on_start_pressed():
	var jump = SoundManager.PlayerJump(2)
	await jump.finished
	get_tree().change_scene_to_file("res://Scenes/Level/StartingCutscene.tscn")


func _on_how_to_pressed():
	SoundManager.PlayerJump(2)
	main_menu.visible = false
	instructions.visible = true

func _on_instructions_return_pressed():
	SoundManager.PlayerJump(2)
	instructions.visible = false
	main_menu.visible = true

func _on_credits_pressed():
	SoundManager.PlayerJump(2)
	main_menu.visible = false
	credits.visible = true

func _on_credits_return_pressed():
	SoundManager.PlayerJump(2)
	credits.visible = false
	main_menu.visible = true
	
func _on_exit_pressed():
	var land = SoundManager.PlayerLand("long")
	await land.finished
	get_tree().quit()

func _on_mouse_entered():
	SoundManager.CoinCollect()
